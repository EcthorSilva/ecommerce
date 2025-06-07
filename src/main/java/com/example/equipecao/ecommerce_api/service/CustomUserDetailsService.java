/* 
 * Classe que implementa a interface UserDetailsService do Spring Security
 * 
 * Esta classe é responsável por carregar um usuário a partir do seu email
 * 
*/

package com.example.equipecao.ecommerce_api.service;

import com.example.equipecao.ecommerce_api.model.Cliente;
import com.example.equipecao.ecommerce_api.model.Usuario;
import com.example.equipecao.ecommerce_api.repository.ClienteRepository;
import com.example.equipecao.ecommerce_api.repository.UsuarioRepository;

import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private ClienteRepository clienteRepository;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Optional<Usuario> usuarioOptional = usuarioRepository.findByEmail(email);
        if (usuarioOptional.isPresent()) {
            return usuarioOptional.get();
        }

        Optional<Cliente> clienteOptional = clienteRepository.findByEmail(email);
        if (clienteOptional.isPresent()) {
            return clienteOptional.get();
        }

        throw new UsernameNotFoundException("Usuário ou cliente não encontrado com o email: " + email);
    }
}
