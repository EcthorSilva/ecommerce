package com.example.equipecao.ecommerce_api.controller;

import com.example.equipecao.ecommerce_api.model.Cliente;
import com.example.equipecao.ecommerce_api.model.Grupo;
import com.example.equipecao.ecommerce_api.repository.ClienteRepository;
import com.example.equipecao.ecommerce_api.util.CPFValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/clientes")
@CrossOrigin
public class ClienteController {

    @Autowired
    private ClienteRepository clienteRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @GetMapping
    public ResponseEntity<List<Cliente>> listAll() {
        List<Cliente> clientes = clienteRepository.findAll();
        return ResponseEntity.ok(clientes);
    }

    // Criar um novo cliente
    @PostMapping
    public ResponseEntity<String> create(@Valid @RequestBody Cliente cliente) {
        if (!isValidEmail(cliente.getEmail())) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Email inválido.");
        }
        if (clienteRepository.findByEmail(cliente.getEmail()).isPresent()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Email já cadastrado.");
        }
        if (!CPFValidator.isValidCPF(cliente.getCpf())) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("CPF inválido.");
        }
        if(clienteRepository.findByCpf(cliente.getCpf()).isPresent()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("CPF já cadastrado.");
        }
        if (cliente.getEmail().equals(cliente.getEmailSecundario())) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Email secundário não pode ser igual ao email de cadastro.");
        }

        // Definir grupo e ativo
        cliente.setGrupo(Grupo.CLIENTE);
        cliente.setAtivo(true);

        // Criptografa a senha antes de salvar
        cliente.setSenha(passwordEncoder.encode(cliente.getSenha()));
        clienteRepository.save(cliente);
        return ResponseEntity.status(HttpStatus.CREATED).body("Cliente cadastrado com sucesso.");
    }

    // Buscar cliente por id
    @GetMapping("/{id}")
    public ResponseEntity<Cliente> getClienteById(@PathVariable Long id) {
        Optional<Cliente> cliente = clienteRepository.findById(id);
        return cliente.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }

    // Atualizar cliente
    @PutMapping("/{id}")
    public ResponseEntity<String> update(@PathVariable long id, @Valid @RequestBody Cliente cliente) {
        if (!clienteRepository.existsById(id)) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Cliente não encontrado.");
        }
        cliente.setId(id);
        clienteRepository.save(cliente);
        return ResponseEntity.ok("Cliente atualizado com sucesso.");
    }

    // Deletar cliente
    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteCliente(@PathVariable Long id) {
        if (!clienteRepository.existsById(id)) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Cliente não encontrado.");
        }
        clienteRepository.deleteById(id);
        return ResponseEntity.ok("Cliente deletado com sucesso.");
    }

    // Atualizar senha
    @PatchMapping("/{id}/update-password")
    public ResponseEntity<String> updatePassword(@PathVariable long id, @RequestParam String novaSenha) {
        Optional<Cliente> clienteOpt = clienteRepository.findById(id);
        if (clienteOpt.isPresent()) {
            Cliente cliente = clienteOpt.get();
            cliente.setSenha(passwordEncoder.encode(novaSenha));
            clienteRepository.save(cliente);
            return ResponseEntity.ok("Senha do cliente atualizada com sucesso.");
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Cliente não encontrado.");
    }

    // Verifica se o email é válido
    private boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        return email.matches(emailRegex);
    }
}