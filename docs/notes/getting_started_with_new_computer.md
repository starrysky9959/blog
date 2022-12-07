<!--
 * @Author: starrysky9959 starrysky9651@outlook.com
 * @Date: 2022-12-06 23:10:01
 * @LastEditors: starrysky9959 starrysky9651@outlook.com
 * @LastEditTime: 2022-12-07 15:24:46
 * @Description:  
-->
# 配置新电脑

## 跳过激活
由于笔记本激活后就不能七天无理由退货了, 而Windows 11第一次开机时又强制联网, <font color="red">一旦联网就会自动激活</font>. 因此需要一些方法暂时跳过联网步骤. 下面给出一种可行的方法.

1. 开机后跟随引导一步步执行, 直到联网阶段
2. 按下`Shift + F10`或者`Fn + Shift + F10`快捷键, 会出现命令提示符cmd
3. 输入并执行命令行`taskmgr`, 出现熟悉的任务管理器
4. 在任务管理器中找到名为**网络连接流**或者**Network Connection Flow**的进程, 将该进程结束即可跳过联网阶段
5. 继续后面的步骤, 完成开机引导

这样就可以在不激活的情况下进入系统了, 然后可以对主要硬件, 接口等进行一些必要的检查. 检查无误后再联网激活.

## 禁止Windows自动更新驱动
我第一次联网后就因为Windows自动更新, 同时将默认驱动也更新导致触控板部分功能失灵.

<font color="red">稳定靠谱的系统必须由自己手动选择更新.</font>

推荐先激活**Windows专业版**, 不然有些功能缺失, 设置起来比较麻烦. 

可以网上搜Key或者求助万能的淘宝. 毕竟微软官方那个零售定价过于离谱, 我有理由认为这是一种强迫电脑厂商OEM采购预装的定价策略.😥

具体步骤:
1. 使用`Windows + R`快捷键, 打开**运行**
2. 输入`gpedit.msc`, 打开**本地组策略编辑器**
3. 导航路径: 计算机配置->管理模板->Windows 组件->Windows 更新->管理从 Windows 更新提供的更新
4. 将**Windows 更新不包括驱动程序**项启用

## 必装软件推荐

不得不提, 现在在Windows上开发的体验和几年前相比已经大大改善了, 微软拥抱开源社区, 拥抱Linux, 近年来推出的WSL, VSCode, Windows Terminal, Edge等实用工具, 真的是赚足了开发者的好感.

### Neat Downloader Manager
很好用的下载工具, 类似很有名的IDM.
- 支持结合浏览器扩展使用
- 支持多线程
- 支持配置代理

Homepage: [https://www.neatdownloadmanager.com/](https://www.neatdownloadmanager.com/)

### 7-Zip
纯粹简洁的压缩工具.
- free software with open source. 无需过多解释

Homepage:[https://www.7-zip.org/](https://www.7-zip.org/)

### Office 365
> "I actually like some of Microsoft applications. I used to use PowerPoint to make my slides when I was talking about Linux for example. I don't think Microsoft is evil in itself; I just think that they make really crappy operating systems." Linus Torvalds once said
> 
> reference link: [http://www.tamos.net/ieee/linus.html](http://www.tamos.net/ieee/linus.html)

必备的办公软件
- Linux之父亲口推荐😊. 
- 自从WPS爆出擅自锁定用户云端文件的丑闻, 我彻底倒向Office. 而且Office 365家庭版包含1T OneDrive非常划算.

推荐使用[Office Tool Plus](https://otp.landian.vip/)进行部署, 这是基于Office官方的[Office Development Tool](https://learn.microsoft.com/en-us/deployoffice/overview-office-deployment-tool)开发的, 很适合自定义, 我一般只需要Word, PowerPoint, Excel三件套和OneDrive. 有时候官网的Office客户端安装失败, 缺乏有效的报错信息, 也可以用这个工具解决.

### Clash 

跨平台的代理客户端. 
- 结合机场使用.

Homepage: [https://github.com/Dreamacro/clash](https://github.com/Dreamacro/clash)

不错的中文文档: [https://docs.cfw.lbyczf.com/](https://docs.cfw.lbyczf.com/)

### Windows Terminal
Windows平台最好的Terminal.
- Windows11 似乎已经自带

在Microsoft Store中获取: [https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701?hl=zh-cn&gl=cn](https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701?hl=zh-cn&gl=cn)

### WSL: Windows Subsystem for Linux

在Windows上体验Linux开发环境

- 与Windows高度融合, 使用起来非常方便

Homepage: [https://learn.microsoft.com/zh-cn/windows/wsl/](https://learn.microsoft.com/zh-cn/windows/wsl/)

### VS Code: Visual Studio Code

个人体验过最棒的文本编辑器

- 丰富的插件, 完全可以配置成多语言IDE使用
- free software with open source. 
- 跨平台, 包括Web.
- 与WSL, git等融合得很好, 再加上微软收购了GitHub, 啧啧
- 内存占用略大, 毕竟是基于electron开发的的, 但是好看就完事了, 感觉目前的优化比几年前已经好多了🤣

Homepage: [https://code.visualstudio.com/](https://code.visualstudio.com/)

### Edge

最棒的浏览器, Windows 11已经自带了. 无需再装Chrome.

- 和Chrome同样基于Chromium, 网页兼容性好, 插件丰富, 甚至Google Store的插件都能牛过来. 前Firefox用户落泪, 没办法, Chromium已经是事实上的标准了, 网页前端优先考虑Chromium内核的浏览器上的体验.
- 得益于和Windows的深度融合, 在内存占用上远胜Chrome.
- 跨平台, 而且由于微软的服务没有墙, 无需代理即可体验多端同步.

Homepage: [https://www.microsoft.com/zh-cn/edge](https://www.microsoft.com/zh-cn/edge)

### drawio

画图工具

- free software with open source. 
- 跨平台, 支持Web
Web: [https://app.diagrams.net/](https://app.diagrams.net/)
Desktop: [https://github.com/jgraph/drawio-desktop](https://github.com/jgraph/drawio-desktop)