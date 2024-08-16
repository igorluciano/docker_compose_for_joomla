# Sobre

- Esqueleto base para subir Joomla com Mysql utilizando docker.

# Requisitos

- É necessário ter instalado `Git` para clonar o projeto e `Docker` para rodar.

- Além disso é recomendado utilizar Linux ou estar trabalhando com WSL no Windows.

# Primeira vez
- Comandos para utilizar na primeira vez quando for criar o projeto

> Informações de conexão com banco e porta de execução estão no `.env`

> Após criado, o projeto rodará em: http://localhost:1111 (igual à PORTA_EXPOSTA_APP do .env)

> E o banco de dados estará disponível para conexões na porta 3306 (igual à PORTA_EXPOSTA_DB do .env)

## 1. Criar container do banco de dados

```bash
docker compose up db --build --force-recreate -d 
```

## 2. Criar container da aplicação
```bash
docker compose up app --build --force-recreate
```

## 3. Permissões necessárias
```bash
# No host onde o container roda
sudo chown -R :www-data app
sudo chmod -R 775 app

# No container da aplicação rodando
docker exec -i project_app sh -c 'chown -R :www-data /var/www/html'
docker exec -i project_app sh -c 'chmod -R 775 /var/www/html/images'
```

## 4. Reiniciar projeto
```bash
docker compose restart
```

## 5. Restaura banco

> Após executar, aguarde até o comando concluir a operação.

```bash
docker exec -i project_db mysql -u admin -p123 banco < ./backup-atual.sql
```

# No dia a dia

- Comandos utilitários para iniciar projeto e outras tarefas rotineiras

## Iniciar projeto
```bash
docker compose up
```

## Reiniciar projeto
```bash
docker compose restart
```

## Logs do projeto
```bash
docker compose logs -f
```

## Backup do banco
```bash
docker exec -i project_db mysqldump -u admin -p123 banco > ./backup-atual.sql
```

# Mudar php.ini

- Caso preciso mudar alguma configuração do PHP, inclua ela no arquivo `php-custom.ini`

- E para refletir a mudança realizada, execute o comando para reinicdiar o projeto

- Por fim, caso deseje conferir no container como está o `php.ini` após a muddança, rode:

```bash
docker exec -i project_app sh -c 'php -i > /var/www/html/phpinfo.txt'

cat ./app/phpinfo.txt 
```


# Credencias do primeiro acesso:

- Acesse a área de administração: http://localhost:1111/administrator e logue com:

```bash
Usuário: administrator
Senha: senhasecreta
```