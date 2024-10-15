document.addEventListener("DOMContentLoaded", function () {
    function validarEmail(email) {
        var regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return regex.test(email);
    }

    function mascara(i) {
        var v = i.value;

        if (isNaN(v[v.length - 1])) { // impede entrada de não-numéricos
            i.value = v.substring(0, v.length - 1);
            return;
        }

        i.setAttribute("maxlength", "14");
        if (v.length == 3 || v.length == 7) i.value += ".";
        if (v.length == 11) i.value += "-";
    }

    // Seleciona o input e associa a função ao evento oninput
    const input = document.querySelector('input[type="text"]'); // Altere o seletor conforme necessário
    if (input) {
        input.addEventListener('input', function () {
            mascara(this);
        });
    }

    function exibirErro(mensagem) {
        var errorDiv = document.querySelector('.alert-danger');
        errorDiv.querySelector('strong').textContent = mensagem;
        errorDiv.classList.remove('visually-hidden');

        setTimeout(function () {
            errorDiv.classList.add('visually-hidden');
        }, 3000);
    }

    async function registrarUsuario(dados) {
        try {
            const response = await fetch('http://localhost:8080/api/usuarios', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(dados)
            });

            if (response.ok) {
                window.location.href = '/login';
            } else {
                const errorData = await response.text();
                exibirErro(errorData);
            }
        } catch (error) {
            exibirErro('Erro ao registrar usuário');
        }
    }

    document.getElementById("signupButton").addEventListener("click", function () {
        var nome = document.getElementById("nome").value;
        var cpf = document.getElementById("cpf").value;
        var email = document.getElementById("email").value;
        var senha = document.getElementById("senha").value;
        var confirmarSenha = document.getElementById("confirmarSenha").value;
        var termos = document.getElementById("termos").checked;

        if (!validarEmail(email)) {
            exibirErro('Email inválido');
            return;
        }

        if (senha !== confirmarSenha) {
            exibirErro('As senhas não coincidem');
            return;
        }

        if (!termos) {
            exibirErro('Você deve aceitar os termos e condições');
            return;
        }

        var dados = {
            nome: nome,
            cpf: cpf,
            email: email,
            senha: senha,
            grupo: 'ESTOQUISTA',
            ativo: true
        };

        registrarUsuario(dados);
    });
});

// validação
(function() {
    const scriptName = document.currentScript.src.split('/').pop();
    console.log(`${scriptName} carregado com sucesso`);
})();