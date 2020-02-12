import setuptools

with open("README.md", "r") as fh:
    long_description = fh.read()

setuptools.setup(
    name="epub-oigusakt-kaarelp2rtel",
    version="1.0.0",
    author="Kaarel Pärtel",
    author_email="kaarelp2rtel@gmail.com",
    description="Script that builds an epub from an Oigusakt",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/KaarelP2rtel/oigusakt",
    packages=['epuboigusakt'],
    include_package_data=True,
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: GPLv3",
        "Operating System :: OS Independent",
    ],
     install_requires=[
          'ebooklib',
          'mako'
      ],
    python_requires='>=3.6',
    entry_points={
          'console_scripts': [
              'epub-oigusakt = epuboigusakt.epuboigusakt:main'
          ]
      },

)