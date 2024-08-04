from maya import cmds

PORT = 5115

if not cmds.commandPort(":{0}".format(PORT), query=True):
    cmds.commandPort(name=":{0}".format(PORT))
