from maya import cmds, mel
PORT = 5115

mel.eval("selectPriority -locator 5;")


if not cmds.commandPort(":{0}".format(PORT), query=True):
    cmds.commandPort(name=":{0}".format(PORT))
