package com.example.equipecao.ecommerce_api.controller;

import com.example.equipecao.ecommerce_api.model.Usuario;
import com.example.equipecao.ecommerce_api.repository.UsuarioRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.util.Optional;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

public class AuthControllerTest {

    @Mock
    private AuthenticationManager authenticationManager;

    @Mock
    private UsuarioRepository usuarioRepository;

    @Mock
    private HttpServletRequest request;

    @Mock
    private HttpSession session;

    @InjectMocks
    private AuthController authController;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testLoginSuccess() {
        Usuario loginRequest = new Usuario();
        loginRequest.setEmail("ecthor@email.com");
        loginRequest.setSenha("123");

        Authentication authentication = mock(Authentication.class);
        when(authenticationManager.authenticate(any(UsernamePasswordAuthenticationToken.class))).thenReturn(authentication);
        when(usuarioRepository.findByEmail("ecthor@email.com")).thenReturn(Optional.of(loginRequest));
        when(request.getSession()).thenReturn(session);

        ResponseEntity<?> response = authController.login(loginRequest, request);

        assertEquals(HttpStatus.OK, response.getStatusCode());
        assertEquals("{\"message\": \"Login successful\"}", response.getBody());
        verify(session).setAttribute("usuario", loginRequest);
    }

    @Test
    public void testLoginFailure() {
        Usuario loginRequest = new Usuario();
        loginRequest.setEmail("ecthor@email.com");
        loginRequest.setSenha("1234");

        when(authenticationManager.authenticate(any(UsernamePasswordAuthenticationToken.class))).thenThrow(new RuntimeException("Authentication failed"));

        ResponseEntity<?> response = authController.login(loginRequest, request);

        assertEquals(HttpStatus.UNAUTHORIZED, response.getStatusCode());
        assertEquals("{\"message\": \"Credenciais inválidas\"}", response.getBody());
    }

    @Test
    public void testLogout() {
        when(request.getSession(false)).thenReturn(session);

        ResponseEntity<?> response = authController.logout(request);

        assertEquals(HttpStatus.OK, response.getStatusCode());
        assertEquals("{\"message\": \"Logout realizado com sucesso\"}", response.getBody());
        verify(session).invalidate();
    }
    
    /* 
     * teste não passou e eu to zero paciencia pra tentar descobrir o pq
     * na verdade eu sei o pq, mas não to conseguindo 
     * corrigir isso pq já me estressei com isso
     */
    @Test
    public void testGetUserInfoAuthenticated() {
        Usuario usuario = new Usuario();
        usuario.setEmail("ecthor@email.com");
    
        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("usuario")).thenReturn(usuario);
    
        Authentication authentication = mock(Authentication.class);
        when(authentication.isAuthenticated()).thenReturn(true);
        when(authentication.getPrincipal()).thenReturn(usuario);
        SecurityContextHolder.getContext().setAuthentication(authentication);
    
        ResponseEntity<?> response = authController.getUserInfo(request);
    
        assertEquals(HttpStatus.OK, response.getStatusCode());
        assertEquals(usuario, response.getBody());
    }

    @Test
    public void testGetUserInfoUnauthenticated() {
        when(request.getSession(false)).thenReturn(null);

        ResponseEntity<?> response = authController.getUserInfo(request);

        assertEquals(HttpStatus.UNAUTHORIZED, response.getStatusCode());
        assertEquals("{\"message\": \"Usuário não autenticado\"}", response.getBody());
    }


}