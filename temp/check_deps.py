import sys
print("Python:", sys.version)

mods = ['docx', 'PyPDF2', 'pptx', 'openpyxl', 'PIL', 'markdownify']
for m in mods:
    try:
        __import__(m)
        print(f"  {m}: OK")
    except ImportError:
        print(f"  {m}: 未安装")
