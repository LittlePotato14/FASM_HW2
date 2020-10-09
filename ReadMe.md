# Точилина Полина БПИ199.
## Вариант 5
### Массив B из элементов A, значение которых не совпадает с введённым числом x

# Код программы
## Секция data.
![alt-текст](https://github.com/LittlePotato14/FASM_HW2/blob/master/Screens/sectionData.png "data")

## Секция code.
При входе в программу запрашиваем у пользователя размер массива.
Сравнением с нулём определяем корректность.
![alt-текст](https://github.com/LittlePotato14/FASM_HW2/blob/master/Screens/startInputN.png "code")
Пр некорректном вводе выводим сообщение об ошибке и просим ввести снова.
![alt-текст](https://github.com/LittlePotato14/FASM_HW2/blob/master/Screens/wrongInp.png "code")
Выделяем память для обоих массивов.
Так как мы заранее не знаем размер массива B, выделяем память для максимально возможной длины (длина A).
![alt-текст](https://github.com/LittlePotato14/FASM_HW2/blob/master/Screens/startReserveMemory.png "code")
Вызываем функцию для ввода массива.
![alt-текст](https://github.com/LittlePotato14/FASM_HW2/blob/master/Screens/startInputArray.png "code")
Ввод массива.
Каждую итерацию вычисляется указатель на следующую ячейку умножением на 4.
![alt-текст](https://github.com/LittlePotato14/FASM_HW2/blob/master/Screens/inputArray.png "code")
Запрашиваем у пользователя число для работы с массивом.
![alt-текст](https://github.com/LittlePotato14/FASM_HW2/blob/master/Screens/startInputX.png "code")
Подготоваливем программу к выводу массива A. Вызываем функцию для вывода.
![alt-текст](https://github.com/LittlePotato14/FASM_HW2/blob/master/Screens/startOutputA.png "code")
Вывод массива. 
Функция вызывется дважды за программу, берет массив из ArrayCur и его размер из SizeCur.
(Можно было забирать данные из регистра, но это показалось неудобным в данном случае).
В остальном работает как и ввод.
![alt-текст](https://github.com/LittlePotato14/FASM_HW2/blob/master/Screens/outputArray.png "code")
Вызываем функцию для обработки массива на основании числа X.
![alt-текст](https://github.com/LittlePotato14/FASM_HW2/blob/master/Screens/startCreationArray.png "code")
Создаём новый массив, не содержащий элементов, по значению равных X.
Если значение не равно, в части кода copyToNewArray вычисляется ячейка для копирования элемента из a в B.
![alt-текст](https://github.com/LittlePotato14/FASM_HW2/blob/master/Screens/createNewArray.png "code")
Подготоваливем программу к выводу массива A. Вызываем функцию для вывода.
Функция вывода уже была описана ранее.
![alt-текст](https://github.com/LittlePotato14/FASM_HW2/blob/master/Screens/startOutputB.png "code")
Чистим память и завершаем процесс.
![alt-текст](https://github.com/LittlePotato14/FASM_HW2/blob/master/Screens/startEnd.png "code")

## Секция idata.
![alt-текст](https://github.com/LittlePotato14/FASM_HW2/blob/master/Screens/sectionIdata.png "idata")

# Тестирование программы
## Тестирование ввода размера массива
Программа запрашивает повтор ввода при некорректных значениях (считаем, что размер массива > 0).
![alt-текст](https://github.com/LittlePotato14/FASM_HW2/blob/master/Screens/inputCheck.png "testing")

## Тестирование ввода и вывода массива
Проверка ввода и вывод одного и того же массива.
![alt-текст](https://github.com/LittlePotato14/FASM_HW2/blob/master/Screens/inputArrayCheck.png "testing")

## Тестирование обработки массива
Тестируем программу на стандартных данных.
![alt-текст](https://github.com/LittlePotato14/FASM_HW2/blob/master/Screens/checkWork1.png "testing")
Тестируем прогамму на массиве элементов одного значения. Получаем пустой массив.
![alt-текст](https://github.com/LittlePotato14/FASM_HW2/blob/master/Screens/checkWork2.png "testing")
