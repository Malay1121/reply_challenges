file = open('input.txt', 'r')
linesData = file.read().split('\n')
testCases = int(linesData[0])
result = []
linesData.pop(0)


def combs(a, n):
    if n == 0:
        return [[]]
    if len(a) == 0:
        return []
    without_current = combs(a[1:], n)
    with_current = [comb + [a[0]] for comb in combs(a[1:], n - 1)]
    return without_current + with_current


for i in range(testCases):
    splittedData = linesData[0].split(' ')
    plants = int(splittedData[2])
    ground = int(splittedData[3])
    linesData.pop(0)
    data = []
    for j in range(ground):
        splittedCoordinate = linesData[0].split(' ')
        coordinate = (int(splittedCoordinate[0]), int(splittedCoordinate[1]))
        data.append(coordinate)
        linesData.pop(0)
    combination = combs(data, plants)
    bestOpton = 0
    for k in range(len(combination)):
        distances = []
        for l in range(len(combination[k])):
            klist = combination[k].copy()
            first = klist[l]
            second = (0, 0)
            totalDistance = 0
            klist.pop(l)
            for z in range(len(klist)):
                second = klist[z]
                distance = abs(second[0]-first[0]) + abs(second[1]-first[1])
                totalDistance += distance
                distances.append(distance)
        distances.sort()
        if (distances[0] > bestOpton):
            bestOpton = distances[0]
    result.append(f'Case #{i + 1}: {bestOpton}\n')

outputFile = open('output.txt', 'w')
print(result)
outputFile.writelines(result)
