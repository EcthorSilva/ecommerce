package com.example.equipecao.ecommerce_api.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;

import org.hibernate.validator.constraints.br.CPF;

@Entity
@Table(name="TB_Cliente")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Cliente {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @NotBlank
    @Size(min = 5, message = "Nome completo deve ter no mínimo 5 caracteres")
    private String nomeCompleto;

    @NotNull
    private LocalDate dataNascimento;

    @NotBlank
    private String genero;

    @NotBlank
    @Email
    private String email;

    @NotBlank
    @CPF
    private String cpf;

    @NotBlank
    @Email
    private String emailSecundario;

    @NotBlank
    private String senha;
}