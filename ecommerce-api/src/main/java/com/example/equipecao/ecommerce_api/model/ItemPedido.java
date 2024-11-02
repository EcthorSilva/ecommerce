package com.example.equipecao.ecommerce_api.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@Entity
@Table(name = "TB_ItemPedido")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ItemPedido {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @NotNull
    private long produtoId;

    @NotNull
    private String nomeProduto;

    @NotNull
    private BigDecimal valorUnitario;

    @NotNull
    private int quantidade;
}
