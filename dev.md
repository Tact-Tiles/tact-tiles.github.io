---
layout: simple
title: Dev
---

# Android

Assim como outros componentes do projeto, o código fonte de três projetos Android estão disponíveis na organização [Tact-Tiles no GitHub](https://github.com/Tact-Tiles):

  - **AndroidAPI:** Biblioteca para Android para criar aplicativos compatíveis com a tecnologia Tact-Tiles.
  - **AndroidRuntime:** Aplicativo Android que faz a conexção entre a luva Helena e os aplicativos compatíveis.
  - **Touché:** Aplicativo oficial para troca de mensagens de texto local, uma pessoa com a luva e outra com o celular, no mesmo ambiente.

## Configurando o ambiente de desenvolvimento

  1. Baixar o [Android Studio](https://developer.android.com/studio/index.html) e instalar seguindo as [instruções no site](https://developer.android.com/studio/install.html).
  1. Baixar os repositórios [AndroidAPI](https://github.com/Tact-Tiles/AndroidAPI/archive/master.zip) e [Touché](https://github.com/Tact-Tiles/Touche/archive/master.zip) (como exemplo)
  1. Descompactar ambos os arquivos gerando os diretórios `AndroidAPI-master` e `Touche-master`
  1. O projeto AndroidAPI é dependência do projeto Touché, portanto a mesma deve estar configurada. Para isso verifique se o caminho para a Biblioteca, definido na linha `4` do aquivo `Touche-master/settings.gradle`, está correto.
      1. Caso o diretório da biblioteca seja `AndroidAPI-master` então a linha deverá ser:
     ```
     project(':ttapi').projectDir = new File(settingsDir, '../AndroidAPI-master/ttapi')
     ```
  1. No Android Studio abra o projeto `Touche-master`
      1. Caso apareça uma pop-up dizendo `Invalid VCS root mapping` ignore
      1. Caso apareça o erro:
      ```
      Error:Failed to find target with hash string 'android-25' in: /home/andy-/Android/Sdk
      Install missing platform(s) and sync project
      ```
          1. Clique em `Install missing platform(s) and sync project` e prossiga baixando a versão 25 do android para compilar o projeto
      1. Caso apareça o erro:
      ```
      Error:Failed to find Build Tools revision 25.0.2
      Install Build Tools 25.0.2 and sync project
      ```
          1. Clique em `Install Build Tools 25.0.2 and sync project` e prossiga baixando a versão 25.0.2 das ferramentas
      1. Caso apareça o erro:
      ```
      Error:Project :app declares a dependency from configuration 'compile' to configuration 'default' which is not declared in the descriptor for project :ttapi.
      ```
      1. Edite o arquivo ``
          1. Vá em `Tools > Android > Sync Project with Graddle Files`
      1. Caso apareça o erro:
      ```
      Error:(25, 13) Failed to resolve: com.android.support.constraint:constraint-layout:1.0.2
      Upgrade plugin to version 2.3.3 and sync project
      ```
          1. Clique em `Upgrade plugin to version 2.3.3 and sync project`
      1. Caso apareça o erro:
      ```
      Error:(25, 13) Failed to resolve: com.android.support.constraint:constraint-layout:1.0.2
      Install artifact and sync project
      ```
          1. Clique em `Install artifact and sync project`
  1. Navegue pela arvore do projeto até o arquivo `app > java > com.tacttiles.touche > ToucheMainActivity`
  1. Nesse arquivo você verá a estrutura básica de como programar a luva, ao criar um novo projeto compatível tente manter o mesmo estilo.

## Utilizando a API

### Setup

  1. Crie um objeto do tipo `Glove`: `glove = new Glove();`
  1. Para a API ter acesso ao aplicativo `Tact-Tiles` (AndroidRuntime) chame o método `connect` passando o contexto da aplicação: `glove.connect(getApplicationContext());`. Esse método irá fazer a conexção entre o seu aplicativo e o aplicativo servidor, quando a luva se conectar ao celular você será notificado pelo evento `Glove.GloveListener.onDeviceFound()`.
  1. Para receber eventos da API, registre uma instancia de `Glove.GloveListener`.
  1. No encerramento de sua atividade (`onDestroy()`) não se esqueça de chamar:
  ```
  glove.getDevice().powerOff();
  glove.getDevice().getServiceConnection().disconnect();
  ```

### Eventos e Ações
  1. A documentação da API está disponível no site [https://tact-tiles.github.io/AndroidAPI/](https://tact-tiles.github.io/AndroidAPI/)
  1. Os eventos recebidos estão descritos na classe [Glove.GloveListener](https://tact-tiles.github.io/AndroidAPI/com/tacttiles/api/Glove.GloveListener.html) e [Device.DeviceListener](https://tact-tiles.github.io/AndroidAPI/com/tacttiles/api/Device.DeviceListener.html)
  1. As principais ações realizadas pelos objetos `Glove` e `Device` são (`Glove` é uma classe derivada de `Device` então possui as mesmas ações):
      1. `Glove.draw()`: desenha um texto na luva
      1. `Device.powerOff()`: desliga a luva
      1. `Device.setTouchSensibility(int sensibility)`: define a sensibilidade ao toque
      1. `Device.vibrateDevice(int times, int duration)`: vibra o dispositivo
