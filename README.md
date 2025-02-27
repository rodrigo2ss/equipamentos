📌 Controle de Equipamentos
Aplicação desenvolvida em Flutter para cadastro e gerenciamento de equipamentos por setores da empresa. O backend foi desenvolvido em PHP e o banco de dados é MySQL (XAMPP).

🖼️ Imagens do Aplicativo
Tela Inicial
<img src="screenshots/tela_inicial.jpg" width="250">
Modal de Cadastro
<img src="screenshots/modal_cadastro.jpg" width="250">
Formulário de Cadastro
<img src="screenshots/formulario_cadastro.jpg" width="250">
Programas Instalados
<img src="screenshots/programas_instalados.jpg" width="250">
Cadastro Concluído
<img src="screenshots/cadastro_concluido.jpg" width="250">
Equipamentos por Setor
<img src="screenshots/equipamentos_setor.jpg" width="250">
Detalhes do Equipamento
<img src="screenshots/detalhes_equipamento.jpg" width="250">
🔧 Tecnologias Utilizadas
Flutter (Front-end)
Dart
PHP (Back-end)
MySQL (Banco de Dados)
XAMPP (Ambiente Local)
Dio (Consumo de API)
Provider (Gerenciamento de estado)
🚀 Instalação e Execução
🔹 Backend (PHP + MySQL)
Instale o XAMPP e inicie o Apache e MySQL.
Crie um banco de dados no phpMyAdmin:
sql
Copiar
Editar
CREATE DATABASE controle_equipamentos;
Importe o arquivo database.sql para criar as tabelas.
Configure o arquivo config.php com suas credenciais do banco de dados.
Inicie o servidor local executando:
sh
Copiar
Editar
php -S localhost:8000
🔹 Frontend (Flutter)
Clone este repositório:
sh
Copiar
Editar
git clone https://github.com/seu-usuario/controle-equipamentos.git
Acesse a pasta do projeto:
sh
Copiar
Editar
cd controle-equipamentos
Instale as dependências:
sh
Copiar
Editar
flutter pub get
Configure a URL base da API no arquivo api_service.dart.
Execute o aplicativo:
sh
Copiar
Editar
flutter run
📌 Funcionalidades
✅ Cadastro de equipamentos por setor
✅ Listagem de equipamentos cadastrados
✅ Detalhes do equipamento
✅ Integração com API em PHP/MySQL

🛠️ Melhorias Futuras
🔹 Implementação de autenticação de usuários
🔹 Filtro e busca de equipamentos
🔹 Exportação de relatórios
🤝 Contribuições
Sinta-se à vontade para abrir issues e pull requests para contribuir com melhorias no projeto. 🚀

📌 Desenvolvido por Seu Nome
