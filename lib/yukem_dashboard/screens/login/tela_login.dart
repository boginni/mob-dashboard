import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_theme.dart';
import 'package:yukem_dashboard/sdk/models/configuracao/app_user.dart';

import '../../component/container_loading.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key, required this.subimit, this.onLoading = false})
      : super(key: key);

  final Function() subimit;

  final bool onLoading;

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  bool isLoading = false;
  bool verSenha = false;

  final TextEditingController controllerUsuario = TextEditingController();
  final TextEditingController controllerPass = TextEditingController();

  AppUser user = AppUser();

  String serverMsg = '';

  @override
  void initState() {
    // user.user = 'lucas';
    // user.pass = '123';

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      user = AppUser.of(context);
      controllerUsuario.text = user.user;
      controllerPass.text = user.pass;
    });
  }

  save() {
    user.user = controllerUsuario.text ?? '';
    user.pass = controllerPass.text ?? '';
    user.login(context).then((value) {
      user.save(passSave: user.onValid);

      setState(() {
        if (user.onValid) {
          widget.subimit();
        } else{
          // serverMsg = 'Usuário ou senha invalidos';
        }
      });


    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColorLight,
              Theme.of(context).primaryColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 0,
                  blurRadius: 5,
                  offset: Offset(0, 0),
                )
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  height: 400,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorTheme
                            .lighten(Theme.of(context).primaryColor, 0.3),
                        Theme.of(context).primaryColor,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  // color: Theme.of(context).primaryColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Dashboard',
                                style: theme.textTheme
                                    .title(color: Colors.white, size: 32),
                              ),
                              Text(
                                'Bem vindo de volta',
                                style: theme.textTheme.body(),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('boginni.net',
                            style: theme.textTheme.subTitle2(size: 12)),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 500,
                  height: 400,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.grey[100]!,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: widget.onLoading
                      ? const ContainerLoading()
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          child: Column(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Signup',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall),
                                    // Focus(
                                    //   onFocusChange: (x) {
                                    //     if (!x) {
                                    //       controllerAmbiente.text =
                                    //           controllerAmbiente.text.trim();
                                    //     }
                                    //   },
                                    //   child: TextFormField(
                                    //     controller: controllerAmbiente,
                                    //     decoration: const InputDecoration(
                                    //       label: Text('Ambiente'),
                                    //       hintText: 'Ambiente',
                                    //     ),
                                    //     autocorrect: false,
                                    //   ),
                                    // ),
                                    Focus(
                                      onFocusChange: (x) {
                                        if (!x) {
                                          controllerUsuario.text =
                                              controllerUsuario.text.trim();
                                        }
                                      },
                                      child: TextFormField(
                                        controller: controllerUsuario,
                                        // enabled: !UserManager.loading,
                                        decoration: const InputDecoration(
                                          label: Text('Usuário'),
                                          hintText: 'Usuário',
                                        ),
                                        autocorrect: false,
                                        // validator: (email) {
                                        //   if (!emailValid(email!)) return 'E-mail inválido';
                                        //   return null;
                                        // },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: TextFormField(
                                            controller: controllerPass,
                                            // enabled: !UserManager.loading,
                                            decoration: const InputDecoration(
                                              label: Text('Senha'),
                                              hintText: 'Senha',
                                            ),
                                            autocorrect: false,
                                            obscureText: !verSenha,
                                            validator: (pass) {
                                              if (pass!.isEmpty ||
                                                  pass.length < 6) {
                                                return 'Senha inválida';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            child: const Icon(
                                                Icons.remove_red_eye_outlined),
                                            onTap: () {
                                              setState(() {
                                                verSenha = !verSenha;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(serverMsg),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      save();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Theme.of(context).primaryColor,
                                        minimumSize: const Size.fromHeight(50)),
                                    child: Builder(builder: (context) {
                                      if (isLoading) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return const Text(
                                        "Entrar",
                                        style: TextStyle(fontSize: 18),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Text(
      //     'boginni.net',
      //     textAlign: TextAlign.center,
      //     style: Theme.of(context).textTheme.titleMedium,
      //   ),
      // ),
    );
  }
}

// class x extends StatelessWidget {
//   const x({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 600,
//       height: 400,
//       child: Card(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('Signup',
//                   style: Theme
//                       .of(context)
//                       .textTheme
//                       .displaySmall),
//               Focus(
//                 onFocusChange: (x) {
//                   if (!x) {
//                     controllerAmbiente.text =
//                         controllerAmbiente.text.trim();
//                   }
//                 },
//                 child: TextFormField(
//                   controller: controllerAmbiente,
//                   // enabled: !UserManager.loading,
//                   decoration: const InputDecoration(
//                     label: AppText('Ambiente'),
//                     hintText: 'Ambiente',
//                   ),
//                   autocorrect: false,
//                 ),
//               ),
//               const SizedBox(
//                 height: 16,
//               ),
//               Focus(
//                 onFocusChange: (x) {
//                   if (!x) {
//                     controllerUsuario.text =
//                         controllerUsuario.text.trim();
//                   }
//                 },
//                 child: TextFormField(
//                   controller: controllerUsuario,
//                   // enabled: !UserManager.loading,
//                   decoration: const InputDecoration(
//                     label: AppText('Usuário'),
//                     hintText: 'Usuário',
//                   ),
//                   autocorrect: false,
//                   // validator: (email) {
//                   //   if (!emailValid(email!)) return 'E-mail inválido';
//                   //   return null;
//                   // },
//                 ),
//               ),
//               const SizedBox(
//                 height: 16,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 5,
//                     child: TextFormField(
//                       controller: controllerPass,
//                       // enabled: !UserManager.loading,
//                       decoration: const InputDecoration(
//                         label: AppText('Senha'),
//                         hintText: 'Senha',
//                       ),
//                       autocorrect: false,
//                       obscureText: !verSenha,
//                       validator: (pass) {
//                         if (pass!.isEmpty || pass.length < 6) {
//                           return 'Senha inválida';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: InkWell(
//                       child: const Icon(Icons.remove_red_eye_outlined),
//                       onTap: () {
//                         setState(() {
//                           verSenha = !verSenha;
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 16,
//               ),
//               ElevatedButton(
//                 onPressed: () => widget.subimit(),
//                 style: ElevatedButton.styleFrom(
//                     primary: Theme
//                         .of(context)
//                         .primaryColor,
//                     minimumSize: const Size.fromHeight(50)),
//                 child: Builder(builder: (context) {
//                   if (isLoading) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                   return const Text(
//                     "Entrar",
//                     style: TextStyle(fontSize: 18),
//                   );
//                 }),
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//               const Center(
//                 child: AppText(Application.versao),
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//               Column(
//                 children: const [
//                   Align(
//                     alignment: Alignment.center,
//                     child: AppText('Error Message'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     )
//     ,;
//   }
// }
