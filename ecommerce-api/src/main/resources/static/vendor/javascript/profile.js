document.addEventListener("DOMContentLoaded", function () {
    let userId = null; // Variável para armazenar o ID do usuário

    // Função para carregar o perfil do usuário
    async function carregarPerfil() {
        function formatarData(dataString) {
            const data = new Date(dataString);
            const dia = String(data.getDate()).padStart(2, '0');
            const mes = String(data.getMonth() + 1).padStart(2, '0'); // Mês é 0-indexado
            const ano = data.getFullYear();
            return `${dia}/${mes}/${ano}`;
        }

        try {
            const response = await fetch('http://localhost:8080/api/auth/me', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                },
                credentials: 'include' // Inclui cookies na requisição
            });

            if (!response.ok) {
                throw new Error('Erro ao carregar perfil');
            }

            const data = await response.json();
            console.log(data);

            // Armazena o ID do usuário para usar na alteração de senha
            userId = data.id;

            // Redireciona para o Backoffice se o grupo não for CLIENTE
            if (data.grupo !== 'CLIENTE') {
                window.location.href = '/backoffice';
                return; // Interrompe a execução para evitar erros
            }

            // Atualiza os elementos HTML com os dados do usuário
            document.querySelector('.userNome').textContent = data.nomeCompleto;
            document.querySelector('.userEmail').textContent = data.email;
            document.querySelector('.userEmailSec').textContent = data.emailSecundario;
            document.querySelector('.userGenero').textContent = data.genero;
            document.querySelector('.userNascimento').textContent = formatarData(data.dataNascimento);
            document.querySelector('.userGrup').textContent = data.grupo;

        } catch (error) {
            console.error('Erro:', error);
        }
    }

    function mostrarToast(tipo) {
        const toastEl = document.getElementById(tipo === 'sucesso' ? 'successToast' : 'errorToast');
        const toast = new bootstrap.Toast(toastEl);
        toast.show();
    }

    // Função para limpar os campos do modal
    function limparCamposModal() {
        document.getElementById('senha').value = '';
        document.getElementById('confirmarSenha').value = '';
    }

    // Função para alterar a senha
    async function alterarSenha() {
        const novaSenha = document.getElementById('senha').value;
        const confirmarSenha = document.getElementById('confirmarSenha').value;

        // Validação: as senhas devem ser iguais
        if (novaSenha !== confirmarSenha) {
            alert('As senhas não coincidem!');
            return;
        }

        try {
            const response = await fetch(`http://localhost:8080/api/clientes/${userId}/update-password?novaSenha=${encodeURIComponent(novaSenha)}`, {
                method: 'PATCH',
                headers: {
                    'Content-Type': 'application/json'
                },
                credentials: 'include' // Inclui cookies na requisição
            });

            if (!response.ok) throw new Error('Erro ao alterar a senha');


            mostrarToast('sucesso');
            limparCamposModal();
            // Fecha o modal após a alteração da senha
            const modal = bootstrap.Modal.getInstance(document.getElementById('modalEditSenhaProfile'));
            modal.hide();

        } catch (error) {
            console.error('Erro:', error);
            mostrarToast('erro');
        }
    }

    // Adiciona o evento ao botão de salvar senha no modal
    document.querySelector('#modalEditSenhaProfile .btn-primary').addEventListener('click', alterarSenha);

    // Chama a função para carregar o perfil quando a página carregar
    carregarPerfil();
});

// Validação para verificar se o script foi carregado corretamente
(function() {
    const scriptName = document.currentScript.src.split('/').pop();
    console.log(`${scriptName} carregado com sucesso`);
})();
