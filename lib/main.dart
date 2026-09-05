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

  
}