document.addEventListener("DOMContentLoaded", function () {
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

    // Chama a função para carregar o perfil quando a página carregar
    carregarPerfil();
});

// Validação para verificar se o script foi carregado corretamente
(function() {
    const scriptName = document.currentScript.src.split('/').pop();
    console.log(`${scriptName} carregado com sucesso`);
})();