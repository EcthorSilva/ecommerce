document.addEventListener("DOMContentLoaded", function () {
    function validarEmail(email) {
        var regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return regex.test(email);
    }

    // Função para exibir mensagens de erro
    function exibirErro(mensagem) {
        var errorDiv = document.querySelector('.alert-danger');
        errorDiv.textContent = mensagem;
        errorDiv.classList.remove('visually-hidden');

        setTimeout(function () {
            errorDiv.classList.add('visually-hidden');
        }, 3000);
    }

    // Função para verificar o login
    document.getElementById("loginButton").addEventListener("click", function () {
        var email = document.getElementById("email").value;
        var password = document.getElementById("senha").value;
        var errorDiv = document.querySelector('.alert-danger');

        // Limpa a mensagem de erro ao tentar fazer login novamente
        errorDiv.classList.add('visually-hidden');

        // Verifica se os campos de e-mail e senha estão preenchidos
        if (email.trim() === "" || password.trim() === "") {
            exibirErro("Por favor, preencha todos os campos.");
            return;
        }

        if (!validarEmail(email)) {
            exibirErro("Por favor, insira um e-mail válido.");
            return;
        }

        fetch("http://localhost:8080/api/auth/login", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded",
            },
            body: 'username=' + encodeURIComponent(email) + '&password=' + encodeURIComponent(password),
        })
            .then(response => {
                if (!response.ok) {
                    return response.json(); // Extrai a mensagem de erro do JSON
                }
                // Se o login for bem-sucedido, obtém o usuário logado
                return obterUsuarioLogado();
            })
            .catch(error => {
                console.error('Erro ao enviar os dados:', error);
                exibirErro('Erro ao enviar os dados: ' + error.message);
            })
            .then(errorResponse => {
                if (errorResponse && errorResponse.message) {
                    exibirErro(errorResponse.message); // Exibe a mensagem de erro, se houver
                }
            });
    });

    // Função para obter o usuário logado e redirecionar com base no grupo
    async function obterUsuarioLogado() {
        try {
            const response = await fetch('http://localhost:8080/api/auth/me', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                },
                credentials: 'include', // Inclui cookies na requisição
            });

            if (!response.ok) {
                throw new Error('Erro ao obter usuário logado');
            }

            const data = await response.json();

            // Redireciona com base no grupo do usuário
            if (data.grupo === "CLIENTE") {
                window.location.href = "/profile"; // Redireciona para perfil
            } else {
                window.location.href = "/backoffice"; // Redireciona para backoffice
            }
        } catch (error) {
            console.error('Erro ao obter usuário logado:', error);
            exibirErro('Erro ao obter usuário logado: ' + error.message);
        }
    }

    // Função para extrair a mensagem de erro do HTML
    function extractError(htmlMessage) {
        var parser = new DOMParser();
        var doc = parser.parseFromString(htmlMessage, 'text/html');
        var h1Element = doc.querySelector('h1');
        if (h1Element) {
            return h1Element.textContent;
        } else {
            return "Ocorreu um erro desconhecido.";
        }
    }

    var campos = document.querySelectorAll('input[type="text"], input[type="email"], input[type="password"]');
    campos.forEach(function (campo) {
        campo.addEventListener("focus", function () {
            var errorDiv = document.querySelector('.alert-danger');
            errorDiv.classList.add('visually-hidden');
        });
    });
});

// validação
(function() {
    const scriptName = document.currentScript.src.split('/').pop();
    console.log(`${scriptName} carregado com sucesso`);
})();