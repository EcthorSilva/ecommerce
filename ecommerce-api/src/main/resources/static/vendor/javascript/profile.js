document.addEventListener("DOMContentLoaded", function () {
    let userId = null; // Armazenar ID do usuário

    // Função para carregar o perfil do usuário
    async function carregarPerfil() {
        function formatarData(dataString) {
            const data = new Date(dataString);
            const dia = String(data.getDate()).padStart(2, '0');
            const mes = String(data.getMonth() + 1).padStart(2, '0');
            const ano = data.getFullYear();
            return `${ano}-${mes}-${dia}`; // Formato compatível com input[type="date"]
        }

        try {
            const response = await fetch('http://localhost:8080/api/auth/me', {
                method: 'GET',
                headers: { 'Content-Type': 'application/json' },
                credentials: 'include'
            });

            if (!response.ok) throw new Error('Erro ao carregar perfil');
            const data = await response.json();
            console.log(data);

            userId = data.id;

            if (data.grupo !== 'CLIENTE') {
                window.location.href = '/backoffice';
                return;
            }

            // Atualiza o HTML com os dados do usuário
            document.querySelector('.userNome').textContent = data.nomeCompleto;
            document.querySelector('.userEmail').textContent = data.email;
            document.querySelector('.userEmailSec').textContent = data.emailSecundario;
            document.querySelector('.userGenero').textContent = data.genero;
            document.querySelector('.userNascimento').textContent = formatarData(data.dataNascimento);
            document.querySelector('.userGrup').textContent = data.grupo;

            // Preenche o modal de edição com os dados do usuário
            preencherModal(data);

        } catch (error) {
            console.error('Erro:', error);
        }
    }

    // Função para preencher o modal com os dados do usuário
    function preencherModal(data) {
        document.getElementById('nome').value = data.nomeCompleto;
        document.getElementById('dataNascimento').value = data.dataNascimento;

        if (data.genero === 'Masculino') {
            document.getElementById('Masculino').checked = true;
        } else if (data.genero === 'Feminino') {
            document.getElementById('Feminino').checked = true;
        }
    }

    // Função para exibir o toast de sucesso ou erro
    function mostrarToast(tipo) {
        const toastEl = document.getElementById(tipo === 'sucesso' ? 'successToast' : 'errorToast');
        const toast = new bootstrap.Toast(toastEl);
        toast.show();
    }

    // Função para limpar os campos do modal
    function limparCamposModal() {
        document.getElementById('nome').value = '';
        document.getElementById('dataNascimento').value = '';
        document.querySelectorAll('input[name="inlineRadioOptions"]').forEach(input => input.checked = false);
    }

    // Função para atualizar os dados pessoais
    async function atualizarDadosPessoais() {
        const nomeCompleto = document.getElementById('nome').value;
        const dataNascimento = document.getElementById('dataNascimento').value;
        const genero = document.querySelector('input[name="inlineRadioOptions"]:checked')?.value || '';

        // Recuperar todos os dados do usuário para preencher o payload corretamente
        const perfilAtual = await fetch(`http://localhost:8080/api/clientes/${userId}`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            },
            credentials: 'include'
        }).then(res => res.json());

        // Preenche o payload com os dados atualizados e existentes
        const payload = {
            id: userId,
            nomeCompleto: nomeCompleto || perfilAtual.nomeCompleto,
            dataNascimento: dataNascimento || perfilAtual.dataNascimento,
            genero: genero || perfilAtual.genero,
            email: perfilAtual.email,
            cpf: perfilAtual.cpf,
            emailSecundario: perfilAtual.emailSecundario,
            senha: perfilAtual.senha // Senha deve ser incluída se obrigatória
        };

        try {
            const response = await fetch(`http://localhost:8080/api/clientes/${userId}`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json'
                },
                credentials: 'include',
                body: JSON.stringify(payload)
            });

            if (!response.ok) {
                const errorMessage = await response.text();
                throw new Error(`Erro: ${response.status} - ${errorMessage}`);
            }

            mostrarToast('sucesso');
            limparCamposModal();

            const modal = bootstrap.Modal.getInstance(document.getElementById('modalEditProfile'));
            modal.hide();

            // Recarrega o perfil atualizado
            carregarPerfil();

        } catch (error) {
            console.error('Erro:', error);
            mostrarToast('erro');
        }
    }

    // Adiciona evento ao botão de salvar no modal de edição
    document.querySelector('#modalEditProfile .btn-primary').addEventListener('click', atualizarDadosPessoais);

    // Limpa os campos ao fechar o modal
    document.getElementById('modalEditProfile').addEventListener('hidden.bs.modal', limparCamposModal);

    // Carrega o perfil do usuário ao carregar a página
    carregarPerfil();
});
