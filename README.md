# Projeto Flutter

Bem-vindo ao projeto Flutter! Este repositório contém uma aplicação desenvolvida em Flutter. Siga as instruções abaixo para configurar e executar o projeto.

## Requisitos
Antes de iniciar, certifique-se de ter instalado os seguintes requisitos:

- [Flutter](https://flutter.dev/docs/get-started/install) (versão mais recente)
- [Dart](https://dart.dev/get-dart)
- [Android Studio](https://developer.android.com/studio) ou [VS Code](https://code.visualstudio.com/)
- Emulador Android ou dispositivo físico configurado

## Instalação

1. Clone o repositório:
   ```sh
   git clone https://github.com/elysonsarmento/data_blood.git
   cd data_blood
   ```

2. Instale as dependências do projeto:
   ```sh
   flutter pub get
   ```

## Executando o Projeto

### Em Dispositivo Físico ou Emulador
1. Conecte um dispositivo Android/iOS ou inicie um emulador.
2. Verifique se o dispositivo foi detectado:
   ```sh
   flutter devices
   ```
3. Execute o aplicativo:
   ```sh
   flutter run
   ```

### Executando no Flutter Web
Caso o projeto suporte Flutter Web, use:
```sh
flutter run -d chrome
```

## Testes
Para rodar os testes automatizados, utilize:
```sh
flutter test
```

## Build
Para gerar o APK:
```sh
flutter build apk
```
Para gerar o AppBundle (para publicação na Play Store):
```sh
flutter build appbundle
```


