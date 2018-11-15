# GUI 接口与说明

**Author： JingX**  2018/07/03



##  数据格式

### 信号基本参数

|    信号参数    |   具体参数   |
| :------------: | :----------: |
|     采样率     |   100 kHz    |
|    调制方式    |     FSK      |
|    载波频率    | 9 kHz 10 kHz |
|    信号频率    |    连续波    |
|    码元速率    |    1 kbps    |
|   扩频码周期   |      31      |
| 本原多项式系数 | 1 0 0 0 0 1  |
|     信噪比     |     0 dB     |
|     通道数     |      1       |
|      长度      |    102.3s    |

### 数据存储格式

1. 文件格式：二进制bin文件；
2. 数据格式：  “double”。



## 数据读取

数据读取在GUI中与matlab的读取方式是一致的，最重要的指标是**确认每次读取的数据长度**，需要各子函数成员尽快协商统一。

使用下面的通用代码进行**子函数**仿真，如果需要修改主函数，一定要做好说明与备注。

~~~matlab
Channel = 1;	// 通道数
DataClipLeng = 100e3;	// 每次读取的数据长度
%fs = app.srv;	// 采样率
fs = 100e3;
%fl = fopen(app.showFilePath.Value, 'r');
FilePath = '';
fl = fopen(FilePath, 'r');  // 读取文件 仿真用
    counter = 0;
    while(~feof(fl))
        try
            DataTemp = fread(fl, [Channel, DataClipLeng], 'double')';  // 注意向量方向
            %DataTemp = DataTemp(:, 1);
        catch
            fclose(fl);
        end
        //--- Users' Function ---//
        .
        .
        .
        
     end
~~~



## 函数接口

主程序可以为函数提供的初始参数仅有：**数据段，采样频率**。

子函数的基础参数初始化尽量在各自子函数内完成。

### 函数内部返回值

函数内部返回值是指与其他运算子函数交互时所必须的数据，**需要在函数说明中提前注明返回的格式**，以方便后续子函数之间的协同。

### 函数GUI返回值

GUI返回值是指最终显示在GUI的参数，如图所示Output区，主要包含调制方式，信号频率，码元速率与扩频码表达式。

![1530614387730](E:\TWNO\TempFiles\screely-1530869604321.png)

在调试的时候不需要使用下列返回值格式，只需要取首字母作为变量名即可。

*例如：app.SigFreField.Value ----> aSigVal*

**调制方式：** 

|          参数           | 返回值格式 | 默认值 |
| :---------------------: | :--------: | :----: |
| app.ModulationText.Text |   string   |  NULL  |

**信号频率：** 

|              参数               | 返回值格式 | 默认值 |
| :-----------------------------: | :--------: | :----: |
|      app.SigFreField.Value      |   double   |   0    |
| app.SigFreUnit.Text(*optional*) |   string   |  kHz   |

备注: 使用app.SigFreUnit.Text更改信号频率之后，需要对app.SigFreField.Value做相应的单位换算。

**码元速率：**

|                参数                 | 返回值格式 | 默认值 |
| :---------------------------------: | :--------: | :----: |
|      app.SymbolRateField.Value      |   double   |   0    |
| app.SymbolRateUnit.Text(*optional*) |   string   |  bps   |

备注：同信号频率。

**扩频码：** 

|            参数            | 返回值格式 | 默认值 |
| :------------------------: | :--------: | :----: |
| app.ConsoleEditField.Value |   string   |  null  |

目的是将PN码显示在Console中，由于Console只能显示文字，需要将PN码利用num2str()转为num转为string

## licCheck

将文件中lic_xxxxxx.t 修改为 lic.t，即可正常使用软件对licence 进行校验。