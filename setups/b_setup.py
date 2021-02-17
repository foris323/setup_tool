import os
from pathlib import Path
from setuptools import setup
from pip._internal.req import parse_requirements as pr

PACKAGE_NAME = Path(__file__).name.replace("_setup.py", "")
REQUIREMENTS_TXT = Path(__file__).parent / f"{PACKAGE_NAME}_requirements.txt"
REQUIRES = [str(x.requirement) for x in pr(str(REQUIREMENTS_TXT), session={})]
os.chdir(str(Path(__file__).parent.parent))


setup(
    name=PACKAGE_NAME,
    version='1.0',
    description='This is a test of the setup',
    author='huoty',
    author_email='sudohuoty@163.com',
    url='https://www.konghy.com',
    packages=[f'PythonLib\\{PACKAGE_NAME}'],
    setup_requires=["wheel"],
    install_requires=REQUIRES,

)
