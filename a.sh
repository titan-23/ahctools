sudo rm -r dist
sudo rm -r build

python3 -m build
python3 -m twine upload --repository testpypi dist/* --verbose
