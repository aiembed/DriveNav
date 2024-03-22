from setuptools import setup

setup(
    name='drive-nav',
    version='1.0.0',
    description='Intelligent route scanning engine',
    author='Dr. Sid Ryan',
    author_email='sid@aiembed.com',
    py_modules=['drive_nav'],  # Correct module name
    entry_points={
        'console_scripts': [
            'drive-nav=drive_nav:main'  # Correct function name
        ]
    },
    install_requires=[
        'picamera'
    ],
)

