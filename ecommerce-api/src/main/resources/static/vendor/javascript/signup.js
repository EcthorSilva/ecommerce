document.addEventListener("DOMContentLoaded", function () {
    function validarEmail(email) {
        var regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return regex.test(email);
    }

    function mascara(i) {
        var v = i.value;

        if (isNaN(v[v.length - 1])) { // Impede entrada de não-numéricos
            i.value = v.substring(0, v.length - 1);
            return;
        }

        i.setAttribute("maxlength", "14");
        if (v.length === 3 || v.length === 7) i.value += ".";
        if (v.length === 11) i.value += "-";
    }

    const cpfInput = document.getElementById("cpf");
    if (cpfInput) {
        cpfInput.addEventListener('input', function () {
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
            const response = await fetch('http://localhost:8080/api/clientes', {
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
        const nomeCompleto = document.getElementById("nome").value;
        const dataNascimento = document.getElementById("dataNascimento").value;
        const cpf = document.getElementById("cpf").value;
        const email = document.getElementById("emailPrincipal").value;
        const emailSecundario = document.getElementById("emailSecundario").value;
        const senha = document.getElementById("senha").value;
        const confirmarSenha = document.getElementById("confirmarSenha").value;
        const termos = document.getElementById("termos").checked;

        // Captura o valor do gênero selecionado
        const genero = document.querySelector('input[name="inlineRadioOptions"]:checked');
        if (!genero) {
            exibirErro('Por favor, selecione o gênero');
            return;
        }

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

        const dados = {
            nomeCompleto: nomeCompleto,
            dataNascimento: dataNascimento,
            genero: genero.value,  // Gênero selecionado
            cpf: cpf,
            email: email,
            emailSecundario: emailSecundario,
            senha: senha
        };

        registrarUsuario(dados);
    });
});

// Validação de carregamento do script
(function () {
    const scriptName = document.currentScript.src.split('/').pop();
    console.log(`${scriptName} carregado com sucesso`);
})();
