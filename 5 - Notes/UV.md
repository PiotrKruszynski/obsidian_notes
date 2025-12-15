Created: 2025-12-1523:19
___
Note:
Jedno narzędzie, które zastępuje kilka klasycznych:

- pip
- pip-tools (pip-compile)
- virtualenv
- częściowo poetry / pipenv

Jest napisane w **Rust**, dlatego działa **bardzo szybko**.
### **Do czego służy**

- tworzenie i zarządzanie **virtualenv**
- instalowanie pakietów (pip install)
- generowanie lockfile (powtarzalne buildy)
- zarządzanie wersjami Pythona
- uruchamianie narzędzi w izolowanym środowisku 

### **Najważniejsze cechy**

- **10–100× szybsze** niż pip
- jeden binarny plik (łatwa instalacja)
- deterministyczne zależności (lockfile)
- pełna zgodność z PyPI i PEP
- bardzo dobrze nadaje się do **Dockerów i CI**



___
Metadata:

Status: #pending
Tags: #empty
