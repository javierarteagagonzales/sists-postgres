import requests

def update_readme():
    repo_owner = 'javierarteagagonzales'
    repo_name = 'sists-postgres'
    api_url = f'https://api.github.com/repos/{repo_owner}/{repo_name}/commits'

    # Obtener los commits por autor
    response = requests.get(api_url)
    commits = response.json()

    # Procesar los commits y actualizar README.md
    with open('README.md', 'w') as readme:
        readme.write('# Commits por Autor\n\n')
        for commit in commits:
            author = commit['commit']['author']['name']
            message = commit['commit']['message']
            readme.write(f'- **{author}**: {message}\n')

if __name__ == '__main__':
    update_readme()
