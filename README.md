# 项目经历：基于 NURBS 的球壳多面体铺砖参数化建模系统

**SphereShellTile：Sphere Shell Tiling with NURBS Patches**

**技术栈：** MATLAB | NURBS Toolbox | 计算几何 | 等几何分析 (IGA)

---

## 项目背景与目标

在等几何分析（Isogeometric Analysis, IGA）与高精度 CAD/CAE 集成的研究中，球面及球壳结构的精确参数化表示是基础难题。传统上，球面无法被单一 NURBS 曲面片无畸变地覆盖，必须采用**多片拼接（multipatch）**策略。本项目旨在构建一套完整的 MATLAB 工具链，实现从多面体对称性出发的球面/球壳 NURBS 铺砖（tiling）参数化，并输出标准化的几何数据，供后续数值求解器直接调用。

---

## 核心贡献

### 算法实现：从顶点到 NURBS 曲面片

基于 Dedoncker 等人的理论工作 *"Bézier tilings of the sphere and applications in benchmarking multipatch isogeometric methods"*，独立实现了核心函数 `MakeTile.m`：

- 接收球面上任意 4 个有序顶点（凸四边形），通过**球极平面投影**（Stereographic Projection，参考 Cobb, 1988）映射至 $z=-r$ 平面；
- 在投影平面上构造以**大圆弧**为边界的 $5\times5$ NURBS 控制网，利用配置点（collocation）方法求解线性系统，反投影得到球面上的双四次（bi-quartic）NURBS 曲面片；
- 支持**符号解**与**数值解**两种模式，兼顾精度与计算效率。

### 多面体对称扩展：覆盖多种分辨率需求

基于立方体单片的参数化结果，通过旋转矩阵自动化组装，系统性地支持了 6 种多面体对称铺砖方案，覆盖从低分辨率到高分辨率的完整谱系：

| 多面体类型 | 面片数量 | 主要文件 |
|:---|:---:|:---|
| Cube（立方体） | 6 | `Multi_SphereFromCube.m` |
| Rhombic dodecahedron（菱形十二面体） | 12 | `Multi_SphereFromRDode.m` |
| Icosahedron（二十面体） | 20 | `Multi_SphereFromIco.m` |
| Deltoidal icositetrahedron（鸢形二十四面体） | 24 | `Multi_SphereFromDIco.m` |
| Rhombic triacontahedron（菱形三十面体） | 30 | `Multi_SphereFromRTria.m` |
| Deltoidal hexecontahedron（鸢形六十面体） | 60 | `Multi_SphereFromDHexe.m` |

每种多面体均配有预计算的控制点数据（`.mat`）与独立的加载函数（`*Load.m`），确保结果可复现、可扩展。

### 球壳体参数化：从曲面到三维 NURBS 体

区别于仅参数化球面的常规做法，本项目进一步实现了**球壳三维体（NURBS volume）**的构造：

- 通过设定内外两层半径（如 $r_{\text{inner}}=98$, $r_{\text{outer}}=100$），分别生成内外 NURBS 曲面片；
- 沿径向（第三参数方向 $u$）将两层控制点拼接，构造次数为 $(4,4,1)$ 的 NURBS 体块（volume patch），完美描述具有一定厚度的球壳几何；
- 开发了完整的球壳专用驱动脚本 `driver_shell.m`（基于立方体 6 片）与 `driver_shell_Hemisphere.m`（基于半球 2 片），可直接生成并可视化球壳体控制网格。

### 数据交换接口：标准化 YAML 几何输出

为了打通 MATLAB 原型与外部工程求解器之间的数据链路，编写了 `writeYAML.m` 输出模块：

- 自动提取每个 NURBS 体块的节点向量（`GLOBAL_S/T/U`）、多项式次数（`DEGREE_S/T/U`）以及所有控制点坐标与权重；
- 按照 $s \to t \to u$ 的规范顺序展平控制点数组，生成结构化的 `patch*.yml` 文件；
- 输出格式严格、可读性强，可直接被基于 YAML 配置的 IGA 或有限元框架解析导入。

---

## 技术亮点与创新

1. **理论到代码的完整落地：** 将高阶球面 Bézier tiling 的数学理论转化为工程可用的 MATLAB 代码，填补了文献中缺乏开源实现工具的空白。
2. **统一的多面体铺砖框架：** 以旋转对称性为核心，构建了可复用的 multipatch 组装模式，使不同面片数量的球面参数化可在同一架构下快速扩展。
3. **壳体结构的三维 NURBS 参数化：** 不仅停留在曲面层面，而是将厚度维度纳入参数化，生成真正的 NURBS 体，为壳体等几何分析提供了精确的几何前处理基础。
4. **可视化与数据输出一体化：** 每个驱动脚本均包含控制点网格与曲面/体的三维可视化，配合标准化 YAML 导出，实现了“建模—可视化—数据交付”的完整闭环。

---

## 成果与影响

- 成功生成了从 2 片（半球壳）到 60 片（鸢形六十面体）多种精度的球壳 NURBS 几何模型；
- 输出的 YAML 文件已被用于后续等几何分析求解器的基准测试（benchmarking）与多片拼接算法验证；
- 代码结构模块化、注释完整，为团队后续开展复杂曲面/multipatch IGA 研究提供了可直接复用的基础平台。
