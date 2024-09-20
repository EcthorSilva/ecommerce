package com.example.equipecao.ecommerce_api.controller;

import com.example.equipecao.ecommerce_api.model.Categoria;
import com.example.equipecao.ecommerce_api.model.ImagemProduto;
import com.example.equipecao.ecommerce_api.model.Produto;
import com.example.equipecao.ecommerce_api.repository.ProdutoRepository;

import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/produtos")
@CrossOrigin
public class ProdutoController {

    @Autowired
    private ProdutoRepository repository;

    @GetMapping
    public Page<Produto> findAll(@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "100") int size) {
        Pageable pageable = PageRequest.of(page, size);
        return repository.findAll(pageable);
    }

    @GetMapping("/{id}")
    public Optional<Produto> findById(@PathVariable long id) {
        return repository.findById(id);
    }

    @PostMapping
    public ResponseEntity<Long> create(@Valid @RequestBody Produto produto) {
        Produto savedProduto = repository.save(produto);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedProduto.getId());
    }

    @PutMapping("/{id}")
    public void update(@Valid @RequestBody Produto produto, @PathVariable long id) {
        if (!repository.existsById(id)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Produto não encontrado");
        }
        produto.setId(id);
        repository.save(produto);
    }

    @ResponseStatus(HttpStatus.NO_CONTENT)
    @DeleteMapping("/{id}")
    public void delete(@PathVariable long id) {
        if (!repository.existsById(id)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Produto não encontrado");
        }
        repository.deleteById(id);
    }

    @PatchMapping("/{id}/status")
    public ResponseEntity<String> updateStatus(@PathVariable long id, @RequestParam boolean ativo) {
        Optional<Produto> produtoOpt = repository.findById(id);
        if (produtoOpt.isPresent()) {
            Produto produto = produtoOpt.get();
            produto.setAtivo(ativo);
            repository.save(produto);
            return ResponseEntity.ok("Status atualizado com sucesso.");
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Produto não encontrado.");
        }
    }

    @GetMapping("/categoria/{categoria}")
    public ResponseEntity<Page<Produto>> findByCategoria(@PathVariable("categoria") String categoriaString,
                                                         @RequestParam(defaultValue = "0") int page,
                                                         @RequestParam(defaultValue = "100") int size) {
        Categoria categoria = Categoria.valueOf(categoriaString.toUpperCase());
        Pageable pageable = PageRequest.of(page, size);
        List<Produto> produtos = repository.findAllByCategoria(categoria, pageable);
        return ResponseEntity.ok(new PageImpl<>(produtos, pageable, produtos.size()));
    }

    @GetMapping("/distribuidor/{distribuidor}")
    public ResponseEntity<Page<Produto>> findByDistribuidor(@PathVariable String distribuidor,
                                                            @RequestParam(defaultValue = "0") int page,
                                                            @RequestParam(defaultValue = "100") int size) {
        Pageable pageable = PageRequest.of(page, size);
        List<Produto> produtos = repository.findAllByDistribuidor(distribuidor, pageable);
        return ResponseEntity.ok(new PageImpl<>(produtos, pageable, produtos.size()));
    }

    @PostMapping("/{id}/imagens")
    public ResponseEntity<String> addImagem(@PathVariable long id, @Valid @RequestBody ImagemProduto imagemProduto) {
        Optional<Produto> produtoOpt = repository.findById(id);
        if (produtoOpt.isPresent()) {
            Produto produto = produtoOpt.get();
            
            // Se a imagem for principal, desmarcar outras imagens principais
            if (imagemProduto.isPrincipal()) {
                produto.getImagens().forEach(imagem -> imagem.setPrincipal(false));
            }
            
            imagemProduto.setProduto(produto);
            produto.getImagens().add(imagemProduto);
            repository.save(produto);
            return ResponseEntity.status(HttpStatus.CREATED).body("Imagem adicionada com sucesso.");
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Produto não encontrado.");
        }
    }

    @DeleteMapping("/{id}/imagens/{imagemId}")
    public ResponseEntity<String> removeImagem(@PathVariable long id, @PathVariable long imagemId) {
        Optional<Produto> produtoOpt = repository.findById(id);
        if (produtoOpt.isPresent()) {
            Produto produto = produtoOpt.get();
            produto.getImagens().removeIf(imagem -> imagem.getId() == imagemId);
            repository.save(produto);
            return ResponseEntity.ok("Imagem removida com sucesso.");
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Produto não encontrado.");
        }
    }

    @GetMapping("/{id}/imagens")
    public ResponseEntity<List<ImagemProduto>> listarImagens(@PathVariable long id) {
        Optional<Produto> produtoOpt = repository.findById(id);
        if (produtoOpt.isPresent()) {
            Produto produto = produtoOpt.get();
            return ResponseEntity.ok(produto.getImagens());
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }

    @GetMapping("/{id}/imagens/{imagemId}")
    public ResponseEntity<ImagemProduto> listarImagemPorId(@PathVariable long id, @PathVariable long imagemId) {
        Optional<Produto> produtoOpt = repository.findById(id);
        if (produtoOpt.isPresent()) {
            Produto produto = produtoOpt.get();
            Optional<ImagemProduto> imagemOpt = produto.getImagens().stream()
                    .filter(imagem -> imagem.getId() == imagemId)
                    .findFirst();
            if (imagemOpt.isPresent()) {
                return ResponseEntity.ok(imagemOpt.get());
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
            }
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }
}