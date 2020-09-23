这是一个显示，播放(列表循环)本地音乐的flutter项目。

> 注：需要配置"AndroidManifest.xml"向用户获取权限。

```
flutter packages pub run build_runner build   // 执行一次build命令
flutter packages pub run build_runner watch  // 文件更改自动打包
flutter packages pub run build_runner watch --delete-conflicting-outputs  // 删除旧文件在打包
```

![](./docs/demo.jpg)

update flutter template:
```shell
λ flutter create --project-name flutter_music --org com.ajanuw ./
```

- [flutter_audio_query 获取本地音乐信息](https://pub.flutter-io.cn/packages/flutter_audio_query)
- [audioplayers 播放音乐](https://pub.flutter-io.cn/packages/audioplayers)
- [如何打包apk?](https://flutter.dev/docs/deployment/android)