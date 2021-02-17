from robot.api import get_model
import sys
import re

try:
    model = get_model(sys.argv[1])
except IndexError:
    model = get_model("test.robot")

setting_section = model.sections[0]
setting_section = [
    x.body for x in model.sections if x.header.tokens[0].type == "SETTING_HEADER"][0]

imported_libs = [x.tokens for x in setting_section]
imported_libs = [[x for x in x if x.type == "NAME"]
                 [0].value for x in imported_libs]
imported_libs = [re.search(r"RobotLib\\\\(.*)\.py", x).group(1)
                 for x in imported_libs if re.search(r"RobotLib\\\\(.*)\.py", x)]

with open("requirements.txt", "w") as f:
    f.write("\n".join(imported_libs))
