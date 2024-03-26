from setuptools import setup

setup(
    name='drivenav',
    version='1.0.0',
    description='Intelligent route scanning engine',
    author='Dr. Sid Ryan',
    author_email='sid@aiembed.com',
    py_modules=['drivenav'],  # Correct module name
    entry_points={
        'console_scripts': [
            'drivenav=drivenav:main'  # Correct function name
        ]
    },
    install_requires=[
        'picamera'
    ],
)

