/* 
 * Configuração de segurança da aplicação
 * 
 * Esta classe é responsável por configurar a segurança da aplicação, definindo as regras de acesso e autenticação,
 * aqui são definidos os endpoints públicos e privados, bem como as configurações de autenticação e autorização,
 * além disso, são definidos os handlers de sucesso e falha de autenticação, e de logout.
 * 
*/

package com.example.equipecao.ecommerce_api.config;

import com.example.equipecao.ecommerce_api.service.CustomUserDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.security.web.authentication.logout.SimpleUrlLogoutSuccessHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Autowired
    private CustomUserDetailsService userDetailsService;

    @Autowired
    private CustomAuthenticationEntryPoint customAuthenticationEntryPoint;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }

    // Configuração de segurança
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable()) // Desabilitar CSRF para testes
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/", "/login", "/signup","/backoffice-login", "/catalog", "/faq", "/cart", "/product", "/401", "/checkout","/api/produtos", "/api/produtos/**", "/api/produtos/search", "/api/produtos/distribuidor/**", "/api/usuarios", "/api/clientes","/static/vendor/**", "/static/assets/**").permitAll() // Permitir acesso público à página de login, arquivos estáticos e etc
                .requestMatchers("/backoffice", "/profile", "/api/auth/me").authenticated() // Requer autenticação para acessar o backoffice, profile e etc
                .anyRequest().authenticated()
            )
            .formLogin(form -> form
                .loginPage("/login")
                .loginProcessingUrl("/api/auth/login")
                .usernameParameter("username")
                .passwordParameter("password")
                .successHandler(authenticationSuccessHandler())
                .failureHandler(authenticationFailureHandler())
                .permitAll()
            )
            .logout(logout -> logout
                .logoutUrl("/api/auth/logout")
                .logoutSuccessHandler(logoutSuccessHandler())
                .permitAll()
            )
            .exceptionHandling(exception -> exception
                .authenticationEntryPoint(customAuthenticationEntryPoint) // Usar o CustomAuthenticationEntryPoint
                .accessDeniedHandler((request, response, accessDeniedException) -> {
                    response.setContentType("application/json;charset=UTF-8");
                    response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                    PrintWriter writer = response.getWriter();
                    writer.write("{\"error\": \"Forbidden\", \"message\": \"" + accessDeniedException.getMessage() + "\"}");
                    writer.flush();
                    writer.close();
                })
            );

        // Configurar o AuthenticationManagerBuilder diretamente
        http.getSharedObject(AuthenticationManagerBuilder.class)
            .userDetailsService(userDetailsService)
            .passwordEncoder(passwordEncoder());

        return http.build();
    }
    // Handlers de sucesso e falha de autenticação
    @Bean
    public AuthenticationSuccessHandler authenticationSuccessHandler() {
        return (request, response, authentication) -> {
            response.setContentType("application/json;charset=UTF-8");
            response.setStatus(HttpServletResponse.SC_OK);
            PrintWriter writer = response.getWriter();
            writer.write("{\"message\": \"Login successful\"}");
            writer.flush();
            writer.close();
        };
    }
    // Handlers de unauthenticated e forbidden
    @Bean
    public AuthenticationFailureHandler authenticationFailureHandler() {
        return new SimpleUrlAuthenticationFailureHandler() {
            @Override
            public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
                response.setContentType("application/json;charset=UTF-8");
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                PrintWriter writer = response.getWriter();
                writer.write("{\"error\": \"Unauthorized\", \"message\": \"" + exception.getMessage() + "\"}");
                writer.flush();
                writer.close();
            }
        };
    }
    // Handler de sucesso de logout
    @Bean
    public LogoutSuccessHandler logoutSuccessHandler() {
        return new SimpleUrlLogoutSuccessHandler() {
            @Override
            public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
                response.setContentType("application/json;charset=UTF-8");
                response.setStatus(HttpServletResponse.SC_OK);
                PrintWriter writer = response.getWriter();
                writer.write("{\"message\": \"Logout successful\"}");
                writer.flush();
                writer.close();
            }
        };
    }
}