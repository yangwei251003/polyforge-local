# 本地增量与验证

上游rx290/polyforge，HEAD 4cbb8b840be5573d5adb17dffd6dd71130f47c39，MIT Copyright(c)2026 Muhammad Asad Waseem。原本机改动7个源码文件：cli.py、geometry下blender_export/freecad_export/photogrammetry/preview_export/spec.py及gui/app.py。完整当前工作文件保存，未覆盖旧提交或修改原件。

额外修补4个外部进程日志读取为UTF-8并容错非法字节；旧GBK读取曾导致实际Blender日志读取线程抛异常、stdout变None。4项新测试使用真正子进程输出中文/非法字节，且保留Blender宏起止标记校验。原CLI测试重复清空capsys导致丢失stderr，现一次读取；不削弱命令状态断言。

真实工具链全量138测试首次123通过/6跳过/9失败，9失败后全部定向复测通过；新4编码测试通过。普通环境独立重跑104通过/38跳过。没有把跳过算作通过；合并覆盖136通过/6未执行，未追加无价值的13分钟全量重复。

OpenSCAD真实CLI导出、Blender5.2与FreeCAD1.1.3库导出均已实际运行。FreeCADCmd标准启动退出1，隔离配置安全模式退出101；其自带Python import FreeCAD/Part可运行，体积6000mm³的10×20×30盒体探针正确，现有FREECAD_BIN覆盖项使用该解释器后几何尺寸和水密性测试通过。未改动用户FreeCAD配置或替换CAD程序。

site模型是本轮OpenSCAD实际生成的200×150×60壁架（796面），不是示意图替代运行；本地原始路径字段从公开模型指标中移除。网页只旋转/查看这个静态产物，不运行Python/OpenSCAD/云模型。36张摄影测量测试图在上游测试中明确为其盒体模板的Blender合成视角，无真实人物或定位；gallery对应上游生成脚本，仍按上游MIT署名保留。
