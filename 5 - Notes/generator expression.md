(expression for item in iterable if condition)

lazy evaluation

save RAM (idealne do pracy na dużych zbiorach)

można używać w for, sum(), any(), all() itp.

```python
msg = ['hi', 'check this offer', 'spam', 'hello', 'spam again']
first_spam = next((m for m in msg if 'spam' in m), None)
print(first_spam)  # 'spam'
```
