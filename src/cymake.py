from distutils.core import setup
from pathlib import Path

from Cython.Build import cythonize
# from Cython.Compiler import Options
from setuptools.extension import Extension

# Options.annotate = True

root_directory = Path(__file__).parent
source_directory = root_directory

extensions = [
    Extension(
        name='.'.join(file.with_suffix("").relative_to(root_directory).parts),
        sources=[str(file)]
    ) for file in source_directory.rglob("*.pyx")
]

setup(
    name='FileParser',
    ext_modules=cythonize(
        module_list=extensions,
        # nthreads=12,
        force=False,
        compiler_directives={
            'language_level': '3'
        },
        # annotate=True
    ),
)
