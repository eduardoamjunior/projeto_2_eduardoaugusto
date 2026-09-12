import 'package:flutter/material.dart';

void main() {
  runApp(const ContadorApp());
}

class ContadorApp extends StatelessWidget {
  //casca de configuração do app
  // não guarda dados
  const ContadorApp({super.key});
  
  // construform, repassa a key para o widget pai indentifica-la
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contador de Inspeção',
      // titulo interno do app

      home: const TelaContador(),
      // tela inicial do app é o widget tela contador
    );
  }
}

class TelaContador extends StatefulWidget {
  //a tela precisa lembrar os dados que mudam (ex: a contage)
  //o nome digitado
  //essa classe ainda não armazena nada por si só, mas declara que tem um state nela

  const TelaContador({super.key});

  @override
  State<TelaContador> createState() => _TelaContadorState();
  //o createState() é o metodo que o flutter chama para criar o objeto de estado "_telacontadorstate" ligado a este widget.
  //o _ é a convenção de quando tá sendo criado um state
}

class _TelaContadorState extends State<TelaContador> {
  //esta é a classe que efetivamente guarda os dados que podem mudar durante o uso do app
  //é a caixinha que consegue ser passada de cidade em cidade (telas)

  int _pecasAprovadas = 0;
  // variavel que guarda a contagem atual de peças aprovadas

  final _nomeController = TextEditingController();
  //TextEditing... é a ponte entre o que aparece na tela (text field) e o dart, 
  //guarda o texto digitado e permite lê-lo a qualquer momento


  final List<String>_registros=[];
  // lista vazia de textos para guardar o histórico de registro

  void _aprovarPeca(){
    //função chamada toda vez que o botão +1 for apertado

    setState((){
      // sempre que um dado do state muda, a ação precisa ocorrer dentro do setstate para que o flutter
      // recarregue a tela com o novo valor
      _pecasAprovadas += 1;
      //aumenta a quantidade de peças
    });
  }

  void _registrarEZerar(){
    //função chamada chamada quando o botão de registrar é clicado

    final nome = _nomeController.text.trim().isEmpty
      ? 'Sem Nome'
      : _nomeController.text.trim();
      // ? = verdadeira e esse : é o falso
      // trim remove espaços em branco
      // se o texto tiver vazio ele é verdadeiro então manda o sem nome
    
    setState((){
      // toda mdança do state entra no set state
      _registros.add('$nome - $_pecasAprovadas peças');
      // print com variavel
      // adiciona o texto no final da lista de registros
      _pecasAprovadas = 0;
      // zera o contador
    });
  }

  @override
  void dispose(){
    // o dispose é chamado quando o usuario sai da tela (removeu da arvore)
    _nomeController.dispose();
    // libera os recursos do controlle (evite deixar memória em uso)

    super.dispose();
    // chama a implementação nativa da classe pai
    //tem que ser a ultima linha do dispose pra limpar tudo corretamente.
  }

  @override
  Widget build(BuildContext context){
    // monta e devolve a árvore de widgets que representa a tela no estado atual (com os valores da variavel do state)
    return Scaffold(
      // esqueleto padrão de uma tela do flutter
      appBar:AppBar(
        title: Text('Inspeção de Peças'),
        // titulo fixo no header
      ),

      body: Padding(
        //padding interno
        padding: const EdgeInsets.all(16.0),
        child: Column(
          //organiza tudo em coluna, tipo flex direction
          children: [
            TextField(
              // campo de texto onde o inspetor digita o nome dele

              controller: _nomeController,
              //liga este campo controller declarado lá em cima
              //é assim que conseguimos ler o texto digitado

              decoration: const InputDecoration(
                // decoração do input
                labelText: 'Nome do inspetor do turno',
                border:OutlineInputBorder(),
              ),

              onChanged:(texto){
                // muda quando tem mudança

                setState((){});
                // cja,a,ps  o set state com um bloco vazio só pra forçar redesenhar a tela
              },
            ),
            const SizedBox(height: 16),
              // o tal do gap
            
            Text(
              _nomeController.text.trim().isEmpty
              ? 'Responsável: Não informado'
              : 'Responsável: ${_nomeController.text.trim()}',
              // ve se tá vazio ou não
              style: const TextStyle(fontSize:16, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            Text(
              '$_pecasAprovadas',
              style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              // fonte grande em negrito para ver a contagem de peca
            ),

            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 8,
              children: [
                FilledButton.icon(
                  onPressed: _aprovarPeca,

                  icon: const Icon(Icons.add),
                  label: const Text('+1 Peça'),
                ),

                OutlinedButton.icon(
                  onPressed: _registrarEZerar,
                  icon: const Icon(Icons.save_alt),
                  label: const Text('Registrar e Zerar'),
                ),
              ],
            ),

            const SizedBox(height: 16),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Histórico do Turno',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 8),

            Expanded(
              child: _registros.isEmpty
                  ? const Center(child: Text('Nenhum registro'))
                  : ListView.builder(
                      itemCount: _registros.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.history),
                            title: Text(_registros[index]),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
