from setuptools import setup

setup(
    name='drive-nav',
    version='1.0',
    description='Intelligent route scanning engine',
    author='Dr. Sid Ryan',
    author_email='sid@aiembed.com',
    py_modules=['drive-nav'],
    entry_points={
        'console_scripts': [
            'drive-nav=drive-nav:main'
        ]
    },
    install_requires=[
        'picamera'
    ],
)

