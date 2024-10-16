document.addEventListener("DOMContentLoaded", function () {
    function validarEmail(email) {
        const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return regex.test(email);
    }

    function validarNome(nome) {
        const palavras = nome.trim().split(/\s+/);
        return palavras.length >= 2 && palavras.every(palavra => palavra.length >= 3);
    }

    function validarCPF(cpf) {
        cpf = cpf.replace(/[^\d]+/g, ''); // Remove não numéricos
        if (cpf.length !== 11 || /^(\d)\1+$/.test(cpf)) return false; // CPF inválido ou com todos dígitos iguais
        
        let soma = 0, resto;
        for (let i = 1; i <= 9; i++) soma += parseInt(cpf.substring(i - 1, i)) * (11 - i);
        resto = (soma * 10) % 11;
        if (resto === 10 || resto === 11) resto = 0;
        if (resto !== parseInt(cpf.substring(9, 10))) return false;

        soma = 0;
        for (let i = 1; i <= 10; i++) soma += parseInt(cpf.substring(i - 1, i)) * (12 - i);
        resto = (soma * 10) % 11;
        if (resto === 10 || resto === 11) resto = 0;
        return resto === parseInt(cpf.substring(10, 11));
    }

    function validarIdade(dataNascimento) {
        const hoje = new Date();
        const nascimento = new Date(dataNascimento);
        let idade = hoje.getFullYear() - nascimento.getFullYear();
        const mes = hoje.getMonth() - nascimento.getMonth();

        if (mes < 0 || (mes === 0 && hoje.getDate() < nascimento.getDate())) {
            idade--;
        }
        return idade >= 18;
    }

    function mascara(i) {
        let v = i.value;

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
        const errorDiv = document.querySelector('.alert-danger');
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
        const genero = document.querySelector('input[name="inlineRadioOptions"]:checked');

        // Validações
        if (!validarNome(nomeCompleto)) {
            exibirErro('O nome deve ter no mínimo 2 palavras com 3 letras cada.');
            return;
        }

        if (!validarIdade(dataNascimento)) {
            exibirErro('Você deve ter no mínimo 18 anos.');
            return;
        }

        if (!validarCPF(cpf)) {
            exibirErro('CPF inválido.');
            return;
        }

        if (!validarEmail(email)) {
            exibirErro('Email principal inválido.');
            return;
        }

        if (!validarEmail(emailSecundario)) {
            exibirErro('Email secundário inválido.');
            return;
        }

        if (email === emailSecundario) {
            exibirErro('Os emails principal e secundário não podem ser iguais.');
            return;
        }

        if (!genero) {
            exibirErro('Por favor, selecione o gênero.');
            return;
        }

        if (senha === '' || confirmarSenha === '') {
            exibirErro('As senhas não podem estar vazias.');
            return;
        }

        if (senha !== confirmarSenha) {
            exibirErro('As senhas não coincidem.');
            return;
        }

        if (!termos) { 
            exibirErro('Você deve aceitar os termos e condições.');
            return;
        }

        const dados = {
            nomeCompleto: nomeCompleto,
            dataNascimento: dataNascimento,
            genero: genero.value,
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
