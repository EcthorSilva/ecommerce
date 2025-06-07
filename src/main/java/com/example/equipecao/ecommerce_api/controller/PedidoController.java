package com.example.equipecao.ecommerce_api.controller;

import com.example.equipecao.ecommerce_api.model.Pedido;
import com.example.equipecao.ecommerce_api.model.StatusPedido;
import com.example.equipecao.ecommerce_api.repository.PedidoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/pedidos")
@CrossOrigin
public class PedidoController {

    @Autowired
    private PedidoRepository pedidoRepository;

    // Criar pedido
    @PostMapping
    public ResponseEntity<Pedido> criarPedido(@RequestBody Pedido pedido) {
        pedido.setStatus(StatusPedido.AGUARDANDO_PAGAMENTO);
        Pedido novoPedido = pedidoRepository.save(pedido);
        return ResponseEntity.status(HttpStatus.CREATED).body(novoPedido);
    }

    // Listar todos os pedidos
    @GetMapping
    public ResponseEntity<List<Pedido>> listarTodosOsPedidos() {
        List<Pedido> pedidos = pedidoRepository.findAll();
        return ResponseEntity.ok(pedidos);
    }

    // Listar pedido por ID
    @GetMapping("/{id}")
    public ResponseEntity<Pedido> listarPedidoPorId(@PathVariable Long id) {
        Optional<Pedido> pedido = pedidoRepository.findById(id);
        return pedido.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    // Listar todos os pedidos por ID do usuário
    @GetMapping("/usuario/{usuarioId}")
    public ResponseEntity<List<Pedido>> listarPedidosPorUsuarioId(@PathVariable Long usuarioId) {
        List<Pedido> pedidos = pedidoRepository.findByClienteId(usuarioId);
        return ResponseEntity.ok(pedidos);
    }

    // Atualizar status do pedido por ID
    @PatchMapping("/{id}/status")
    public ResponseEntity<Pedido> atualizarStatusPedido(@PathVariable Long id, @RequestParam StatusPedido status) {
        Optional<Pedido> pedidoOptional = pedidoRepository.findById(id);
        if (pedidoOptional.isPresent()) {
            Pedido pedido = pedidoOptional.get();
            pedido.setStatus(status);
            pedidoRepository.save(pedido);
            return ResponseEntity.ok(pedido);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    // Excluir pedido
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> excluirPedido(@PathVariable Long id) {
        if (pedidoRepository.existsById(id)) {
            pedidoRepository.deleteById(id);
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}