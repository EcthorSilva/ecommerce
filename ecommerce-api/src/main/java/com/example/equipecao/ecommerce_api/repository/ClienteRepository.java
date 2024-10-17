/* 
 * Interface que extende JpaRepository, que é uma interface de persistência do Spring Data JPA.
*/

package com.example.equipecao.ecommerce_api.repository;

import com.example.equipecao.ecommerce_api.model.Cliente;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface ClienteRepository extends JpaRepository<Cliente, Long> {
    Optional<Cliente> findByEmail(String email);
    Optional<Cliente> findByCpf(String cpf);
}