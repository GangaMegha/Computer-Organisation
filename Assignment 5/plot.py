import matplotlib.pyplot as plt

x = [16, 32, 64, 128]
y1 = [4.81, 4.76, 4.74, 4.81]
y2 = [0.39, 0.39, 0.39, 0.39]

fig = plt.figure(0)
plt.clf()
plt.title("Variation of Miss Rate with Block Size for Core0")
plt.xlabel("Block Size")
plt.ylabel("Miss Rate")
plt.plot(x, y1, label="Core0")

fig = plt.figure(1)
plt.clf()
plt.title("Variation of Miss Rate with Block Size for Core1")
plt.xlabel("Block Size")
plt.ylabel("Miss Rate")
plt.plot(x, y2, label="Core1")
plt.show()