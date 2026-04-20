#pytorch

## Tensory

```python
import torch

torch.tensor([1, 2, 3])          # tensor z listy
torch.zeros(3, 4)                 # same zera
```
`images = torch.zeros(10, 3, 256, 256)` 
$10 \times 3 \times 256 \times 256 = 1,966,080$ zer. 
>Pamiętaj, że PyTorch używa formatu **NCHW** (Batch, Channels, Height, Width)
>

```
torch.ones(3, 4)                  # same jedynki
torch.rand(3, 4)                  # losowe [0, 1)
torch.randn(3, 4)                 # losowe, rozkład normalny
torch.arange(0, 10, 2)           # jak range()
torch.linspace(0, 1, 5)          # równomiernie rozłożone

t.shape                           # wymiary
t.dtype                           # typ danych
t.device                          # cpu / cuda
```

## Operacje na tensorach

```python
t.view(2, -1)                     # zmień kształt (współdzieli pamięć)
t.reshape(2, -1)                  # zmień kształt (bezpieczniejsze)
t.squeeze()                       # usuń wymiary rozmiaru 1
t.unsqueeze(0)                    # dodaj wymiar
t.permute(2, 0, 1)               # zmień kolejność wymiarów
t.transpose(0, 1)                 # zamień dwa wymiary

torch.cat([a, b], dim=0)         # sklejanie
torch.stack([a, b], dim=0)       # nowy wymiar

a @ b                             # mnożenie macierzy
a * b                             # element-wise
a.sum(), a.mean(), a.max()       # redukcje
```

## GPU

```python
device = "cuda" if torch.cuda.is_available() else "cpu"

t = t.to(device)
t = t.cuda()
t = t.cpu()
```

## Gradienty

```python
t = torch.tensor(2.0, requires_grad=True)

y = t ** 2
y.backward()          # liczy gradienty
t.grad               # dostęp do gradientu

# wyłącz gradient (np. przy inferencji)
with torch.no_grad():
    ...

t.detach()           # odłącz od grafu obliczeń
```

## Budowanie modelu
PyTorch pozwala definiować sieci neuronowe poprzez `torch.nn.Module`, który jest klasą bazową dla wszystkich modeli.
Dzięki temu masz standardowy framework do:

- budowy modelu
- trenowania (forward + backward)

Przykład:
> prosty perceptron z jedną warstwą gęstą (fully-connected / linear):  
> **y = σ(Wx + b)**

gdzie:
- **W** → macierz wag
- **b** → bias (przesunięcie)
- **x** → wejście
- **σ (sigmoid)** → funkcja aktywacji
- **y** → wyjście modelu

```python
import torch.nn as nn

class Model(nn.Module):
    def __init__(self):
        super().__init__()
        self.fc1 = nn.Linear(784, 128)
        self.fc2 = nn.Linear(128, 10)
        self.relu = nn.ReLU()

    def forward(self, x):
        x = self.relu(self.fc1(x))
        return self.fc2(x)

model = Model().to(device)
```

## Popularne warstwy

```python
nn.Linear(in, out)
nn.Conv2d(in_ch, out_ch, kernel_size)
nn.MaxPool2d(kernel_size)
nn.BatchNorm2d(num_features)
nn.Dropout(p=0.5)
nn.Embedding(vocab_size, embed_dim)
nn.LSTM(input_size, hidden_size)
nn.Transformer(...)
```

## Funkcje aktywacji

```python
nn.ReLU()
nn.Sigmoid()
nn.Tanh()
nn.Softmax(dim=1)
nn.LeakyReLU(0.01)
nn.GELU()
```

## Loss i optymalizator

```python
loss_fn = nn.CrossEntropyLoss()
loss_fn = nn.MSELoss()
loss_fn = nn.BCEWithLogitsLoss()

optimizer = torch.optim.SGD(model.parameters(), lr=0.01)
optimizer = torch.optim.Adam(model.parameters(), lr=1e-3)
optimizer = torch.optim.AdamW(model.parameters(), lr=1e-3, weight_decay=1e-2)
```

## Pętla treningowa

```python
model.train()
for X, y in dataloader:
    X, y = X.to(device), y.to(device)

    pred = model(X)
    loss = loss_fn(pred, y)

    optimizer.zero_grad()   # wyczyść stare gradienty
    loss.backward()         # backprop
    optimizer.step()        # aktualizuj wagi
```

## Ewaluacja

```python
model.eval()
with torch.no_grad():
    for X, y in val_loader:
        pred = model(X)
        ...
```

## Dataset i DataLoader

```python
from torch.utils.data import Dataset, DataLoader, random_split

class MyDataset(Dataset):
    def __init__(self): ...
    def __len__(self): return len(self.data)
    def __getitem__(self, idx): return self.data[idx], self.labels[idx]

loader = DataLoader(dataset, batch_size=32, shuffle=True, num_workers=4)
```

## Zapis i wczytanie modelu

```python
# tylko wagi (zalecane)
torch.save(model.state_dict(), "model.pth")
model.load_state_dict(torch.load("model.pth"))

# cały model
torch.save(model, "model.pth")
model = torch.load("model.pth")
```

## Scheduler (zmiana lr)

```python
scheduler = torch.optim.lr_scheduler.StepLR(optimizer, step_size=10, gamma=0.1)
scheduler = torch.optim.lr_scheduler.CosineAnnealingLR(optimizer, T_max=100)

# po każdej epoce
scheduler.step()
```

## Przydatne drobiazgi

```python
torch.manual_seed(42)            # reprodukowalność
torch.cuda.manual_seed(42)

model.parameters()               # wszystkie wagi
model.named_parameters()         # wagi + nazwy

sum(p.numel() for p in model.parameters())   # liczba parametrów
```

