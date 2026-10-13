-- VIET HUB | ROBLOX
-- Giao dien tieng Viet - Dark hien dai
-- Dat trong LocalScript tai StarterPlayerScripts

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local OldGui = PlayerGui:FindFirstChild("VietHub")
if OldGui then OldGui:Destroy() end

local Mau = {
    Nen = Color3.fromRGB(17, 19, 27),
    Khung = Color3.fromRGB(25, 28, 39),
    Nut = Color3.fromRGB(36, 40, 54),
    Chu = Color3.fromRGB(240, 243, 250),
    Phu = Color3.fromRGB(158, 167, 185),
    Diem = Color3.fromRGB(105, 112, 255),
    Xanh = Color3.fromRGB(75, 205, 145),
    Do = Color3.fromRGB(235, 90, 105)
}

local function Tao(Loai, ThuocTinh, Cha)
    local Vat = Instance.new(Loai)
    for Ten, GiaTri in pairs(ThuocTinh) do
        Vat[Ten] = GiaTri
    end
    Vat.Parent = Cha
    return Vat
end

local function BoGoc(Vat, BanKinh)
    Tao("UICorner", {
        CornerRadius = UDim.new(0, BanKinh or 9)
    }, Vat)
end

local function TaoChu(Cha, NoiDung, CoChu, MauChu)
    return Tao("TextLabel", {
        BackgroundTransparency = 1,
        Text = NoiDung,
        TextColor3 = MauChu or Mau.Chu,
        TextSize = CoChu or 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        TextWrapped = true
    }, Cha)
end

local function TaoNut(Cha, NoiDung, HamBam)
    local Nut = Tao("TextButton", {
        BackgroundColor3 = Mau.Nut,
        Text = NoiDung,
        TextColor3 = Mau.Chu,
        TextSize = 13,
        Font = Enum.Font.GothamMedium,
        AutoButtonColor = true
    }, Cha)

    BoGoc(Nut, 8)

    Nut.Activated:Connect(function()
        if HamBam then
            HamBam(Nut)
        end
    end)

    return Nut
end

local GiaoDien = Tao("ScreenGui", {
    Name = "VietHub",
    ResetOnSpawn = false,
    DisplayOrder = 20
}, PlayerGui)

local CuaSo = Tao("Frame", {
    Size = UDim2.fromOffset(660, 440),
    Position = UDim2.new(0.5, -330, 0.5, -220),
    BackgroundColor3 = Mau.Nen,
    BorderSizePixel = 0,
    ClipsDescendants = true
}, GiaoDien)

BoGoc(CuaSo, 14)

Tao("UIStroke", {
    Color = Color3.fromRGB(51, 56, 75),
    Thickness = 1
}, CuaSo)

local ThanhDau = Tao("Frame", {
    Size = UDim2.new(1, 0, 0, 60),
    BackgroundColor3 = Mau.Khung,
    BorderSizePixel = 0
}, CuaSo)

local TieuDe = TaoChu(
    ThanhDau,
    "VIET HUB  |  TRUNG TAM KIEM THU",
    17
)
TieuDe.Position = UDim2.fromOffset(18, 4)
TieuDe.Size = UDim2.new(1, -120, 0, 30)
TieuDe.Font = Enum.Font.GothamBold

local TrangThai = TaoChu(
    ThanhDau,
    "● Dang hoat dong",
    11,
    Mau.Xanh
)
TrangThai.Position = UDim2.fromOffset(19, 32)
TrangThai.Size = UDim2.new(1, -120, 0, 18)

local ThuGon = false

local NutThuGon = TaoNut(ThanhDau, "—", function(Nut)
    ThuGon = not ThuGon
    CuaSo.Size = ThuGon
        and UDim2.fromOffset(660, 60)
        or UDim2.fromOffset(660, 440)
    Nut.Text = ThuGon and "+" or "—"
end)

NutThuGon.Size = UDim2.fromOffset(38, 34)
NutThuGon.Position = UDim2.new(1, -49, 0, 13)

-- Keo cua so
local DangKeo = false
local ViTriDau
local ViTriCuaSo

ThanhDau.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then
        DangKeo = true
        ViTriDau = Input.Position
        ViTriCuaSo = CuaSo.Position
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if DangKeo and (
        Input.UserInputType == Enum.UserInputType.MouseMovement
        or Input.UserInputType == Enum.UserInputType.Touch
    ) then
        local Chenh = Input.Position - ViTriDau
        CuaSo.Position = UDim2.new(
            ViTriCuaSo.X.Scale,
            ViTriCuaSo.X.Offset + Chenh.X,
            ViTriCuaSo.Y.Scale,
            ViTriCuaSo.Y.Offset + Chenh.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then
        DangKeo = false
    end
end)

local ThanhBen = Tao("Frame", {
    Position = UDim2.fromOffset(12, 72),
    Size = UDim2.new(0, 155, 1, -84),
    BackgroundColor3 = Mau.Khung,
    BorderSizePixel = 0
}, CuaSo)

BoGoc(ThanhBen, 10)

Tao("UIPadding", {
    PaddingTop = UDim.new(0, 12),
    PaddingLeft = UDim.new(0, 9),
    PaddingRight = UDim.new(0, 9)
}, ThanhBen)

Tao("UIListLayout", {
    Padding = UDim.new(0, 7),
    SortOrder = Enum.SortOrder.LayoutOrder
}, ThanhBen)

local VungNoiDung = Tao("Frame", {
    Position = UDim2.fromOffset(179, 72),
    Size = UDim2.new(1, -191, 1, -84),
    BackgroundTransparency = 1
}, CuaSo)

local CacTrang = {}
local CacNutTab = {}

local function TaoTrang(Ten)
    local Trang = Tao("ScrollingFrame", {
        Name = Ten,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Mau.Khung,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Mau.Diem,
        CanvasSize = UDim2.new(),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = false
    }, VungNoiDung)

    BoGoc(Trang, 10)

    Tao("UIPadding", {
        PaddingTop = UDim.new(0, 14),
        PaddingBottom = UDim.new(0, 14),
        PaddingLeft = UDim.new(0, 14),
        PaddingRight = UDim.new(0, 14)
    }, Trang)

    Tao("UIListLayout", {
        Padding = UDim.new(0, 9),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, Trang)

    CacTrang[Ten] = Trang
    return Trang
end

local function ChuyenTrang(Ten)
    for TenTrang, Trang in pairs(CacTrang) do
        Trang.Visible = TenTrang == Ten
    end

    for TenTab, Nut in pairs(CacNutTab) do
        Nut.BackgroundColor3 = TenTab == Ten
            and Mau.Diem or Mau.Nut
    end
end

local function ThemTab(Ten, Nhan, ThuTu)
    local Nut = TaoNut(ThanhBen, Nhan, function()
        ChuyenTrang(Ten)
    end)

    Nut.Size = UDim2.new(1, 0, 0, 39)
    Nut.LayoutOrder = ThuTu
    CacNutTab[Ten] = Nut

    return TaoTrang(Ten)
end

local function ThemTieuDe(Trang, NoiDung)
    local Chu = TaoChu(Trang, NoiDung, 18)
    Chu.Font = Enum.Font.GothamBold
    Chu.Size = UDim2.new(1, 0, 0, 31)
    return Chu
end

local function ThemMoTa(Trang, NoiDung, ChieuCao)
    local Chu = TaoChu(Trang, NoiDung, 12, Mau.Phu)
    Chu.Size = UDim2.new(1, 0, 0, ChieuCao or 36)
    Chu.TextYAlignment = Enum.TextYAlignment.Top
    return Chu
end

local function ThemThe(Trang, NoiDung, ChieuCao)
    local The = Tao("Frame", {
        Size = UDim2.new(1, -2, 0, ChieuCao or 57),
        BackgroundColor3 = Mau.Nut,
        BorderSizePixel = 0
    }, Trang)

    BoGoc(The, 8)

    local Chu = TaoChu(The, NoiDung, 13)
    Chu.Position = UDim2.fromOffset(12, 5)
    Chu.Size = UDim2.new(1, -24, 1, -10)

    return The, Chu
end

-- TONG QUAN
local TrangChinh = ThemTab("Chinh", "⌂  Tong quan", 1)

ThemTieuDe(TrangChinh, "Xin chao, " .. Player.DisplayName)
ThemMoTa(TrangChinh, "Bang dieu khien kiem thu Roblox cua ban.")

ThemThe(
    TrangChinh,
    "VIET HUB\nGiao dien tieng Viet, phong cach toi hien dai.",
    65
)

ThemThe(
    TrangChinh,
    "Che do an toan\nChi doc thong tin co san tren may khach.",
    65
)

local NutDong = TaoNut(TrangChinh, "Dong giao dien", function()
    GiaoDien:Destroy()
end)

NutDong.Size = UDim2.new(1, -2, 0, 38)
NutDong.BackgroundColor3 = Mau.Do

-- NGUOI CHOI
local TrangNguoiChoi = ThemTab(
    "NguoiChoi",
    "♙  Nguoi choi",
    2
)

ThemTieuDe(TrangNguoiChoi, "Thong tin nguoi choi")
ThemMoTa(TrangNguoiChoi, "Chon mot nguoi trong danh sach.", 30)

local DanhSach = Tao("Frame", {
    Size = UDim2.new(1, -2, 0, 120),
    BackgroundTransparency = 1
}, TrangNguoiChoi)

Tao("UIListLayout", {
    Padding = UDim.new(0, 5),
    SortOrder = Enum.SortOrder.LayoutOrder
}, DanhSach)

local TieuDeChiTiet = ThemTieuDe(
    TrangNguoiChoi,
    "Chua chon nguoi choi"
)

TieuDeChiTiet.TextSize = 14

local MoTaChiTiet = ThemMoTa(
    TrangNguoiChoi,
    "Thong tin se hien o day.",
    95
)

local NguoiDuocChon

local function CapNhatChiTiet()
    local Nguoi = NguoiDuocChon

    if not Nguoi or Nguoi.Parent ~= Players then
        TieuDeChiTiet.Text = "Chua chon nguoi choi"
        MoTaChiTiet.Text = "Hay chon mot nguoi trong danh sach."
        return
    end

    local NhanVat = Nguoi.Character
    local Humanoid = NhanVat
        and NhanVat:FindFirstChildOfClass("Humanoid")

    TieuDeChiTiet.Text =
        Nguoi.DisplayName .. " (@" .. Nguoi.Name .. ")"

    MoTaChiTiet.Text = string.format(
        "Tai khoan: %s\nID: %d\nMau: %d / %d\nToc do: %.1f\nNhan vat: %s",
        Nguoi.Name,
        Nguoi.UserId,
        Humanoid and math.floor(Humanoid.Health) or 0,
        Humanoid and math.floor(Humanoid.MaxHealth) or 0,
        Humanoid and Humanoid.WalkSpeed or 0,
        NhanVat and "Da xuat hien" or "Chua xuat hien"
    )
end

local function CapNhatDanhSach()
    for _, Vat in ipairs(DanhSach:GetChildren()) do
        if Vat:IsA("TextButton") then
            Vat:Destroy()
        end
    end

    for _, Nguoi in ipairs(Players:GetPlayers()) do
        local Nut = TaoNut(
            DanhSach,
            Nguoi.DisplayName .. " (@" .. Nguoi.Name .. ")",
            function()
                NguoiDuocChon = Nguoi
                CapNhatChiTiet()
            end
        )

        Nut.Size = UDim2.new(1, 0, 0, 32)
        Nut.LayoutOrder = Nguoi.UserId
    end

    CapNhatChiTiet()
end

Players.PlayerAdded:Connect(CapNhatDanhSach)

Players.PlayerRemoving:Connect(function(Nguoi)
    if NguoiDuocChon == Nguoi then
        NguoiDuocChon = nil
    end

    CapNhatDanhSach()
end)

-- MAY CHU
local TrangMayChu = ThemTab(
    "MayChu",
    "▤  May chu",
    3
)

ThemTieuDe(TrangMayChu, "Thong tin phien choi")

local _, TheSoNguoi = ThemThe(TrangMayChu, "So nguoi choi: ...")
local _, TheThoiGian = ThemThe(TrangMayChu, "Thoi gian chay: ...")
local _, TheMaTran = ThemThe(TrangMayChu, "PlaceId: ...\nJobId: ...", 68)

ThemThe(
    TrangMayChu,
    "Luu y\nClient chi doc duoc thong tin phien choi co san."
)

local function CapNhatMayChu()
    TheSoNguoi.Text =
        "So nguoi choi: " .. #Players:GetPlayers()

    TheThoiGian.Text =
        "Thoi gian chay: "
        .. math.floor(workspace.DistributedGameTime)
        .. " giay"

    TheMaTran.Text =
        "PlaceId: " .. tostring(game.PlaceId)
        .. "\nJobId: "
        .. (game.JobId ~= "" and game.JobId or "Khong co ma phien")
end

-- TU DONG
local TrangTuDong = ThemTab(
    "TuDong",
    "⟳  Tu dong",
    4
)

ThemTieuDe(TrangTuDong, "Tac vu tu dong")

ThemMoTa(
    TrangTuDong,
    "Tu dong cap nhat thong tin tren giao dien.",
    42
)

local TuDongBat = true

local NutTuDong = TaoNut(
    TrangTuDong,
    "Tu dong cap nhat: BAT",
    function(Nut)
        TuDongBat = not TuDongBat

        Nut.Text = "Tu dong cap nhat: "
            .. (TuDongBat and "BAT" or "TAT")

        Nut.BackgroundColor3 =
            TuDongBat and Mau.Xanh or Mau.Nut
    end
)

NutTuDong.Size = UDim2.new(1, -2, 0, 40)
NutTuDong.BackgroundColor3 = Mau.Xanh

local _, TrangThaiTuDong = ThemThe(
    TrangTuDong,
    "Tac vu: cap nhat thong tin nguoi choi va may chu.",
    65
)

local NutCapNhat = TaoNut(
    TrangTuDong,
    "Cap nhat ngay",
    function()
        CapNhatDanhSach()
        CapNhatMayChu()
        TrangThaiTuDong.Text = "Da cap nhat thong tin."
    end
)

NutCapNhat.Size = UDim2.new(1, -2, 0, 38)

-- HIEN THI
local TrangHienThi = ThemTab(
    "HienThi",
    "◉  Hien thi",
    5
)

ThemTieuDe(TrangHienThi, "Cong cu hien thi")

ThemMoTa(
    TrangHienThi,
    "Hieu ung chi hien thi tren may cua ban.",
    38
)

local DanhDauBat = false
local TenBat = false

local function XoaHieuUng(NhanVat)
    for _, Vat in ipairs(NhanVat:GetDescendants()) do
        if Vat.Name == "VietHub_DanhDau"
            or Vat.Name == "VietHub_Ten" then
            Vat:Destroy()
        end
    end
end

local function CapNhatHienThi(Nguoi)
    if Nguoi == Player or not Nguoi.Character then
        return
    end

    local NhanVat = Nguoi.Character
    XoaHieuUng(NhanVat)

    if DanhDauBat then
        local DanhDau = Instance.new("Highlight")
        DanhDau.Name = "VietHub_DanhDau"
        DanhDau.FillColor = Mau.Diem
        DanhDau.OutlineColor = Mau.Xanh
        DanhDau.FillTransparency = 0.72
        DanhDau.DepthMode = Enum.HighlightDepthMode.Occluded
        DanhDau.Parent = NhanVat
    end

    if TenBat then
        local Dau = NhanVat:FindFirstChild("Head")

        if Dau then
            local BangTen = Instance.new("BillboardGui")
            BangTen.Name = "VietHub_Ten"
            BangTen.Size = UDim2.fromOffset(180, 30)
            BangTen.StudsOffset = Vector3.new(0, 2.7, 0)
            BangTen.AlwaysOnTop = false
            BangTen.Adornee = Dau
            BangTen.Parent = NhanVat

            local ChuTen = Instance.new("TextLabel")
            ChuTen.Size = UDim2.fromScale(1, 1)
            ChuTen.BackgroundTransparency = 1
            ChuTen.Text = Nguoi.DisplayName
            ChuTen.TextColor3 = Color3.new(1, 1, 1)
            ChuTen.TextStrokeTransparency = 0.4
            ChuTen.TextScaled = true
            ChuTen.Font = Enum.Font.GothamBold
            ChuTen.Parent = BangTen
        end
    end
end

local function CapNhatTatCaHienThi()
    for _, Nguoi in ipairs(Players:GetPlayers()) do
        CapNhatHienThi(Nguoi)
    end
end

local NutDanhDau = TaoNut(
    TrangHienThi,
    "Danh dau nhan vat: TAT",
    function(Nut)
        DanhDauBat = not DanhDauBat

        Nut.Text = "Danh dau nhan vat: "
            .. (DanhDauBat and "BAT" or "TAT")

        Nut.BackgroundColor3 =
            DanhDauBat and Mau.Xanh or Mau.Nut

        CapNhatTatCaHienThi()
    end
)

NutDanhDau.Size = UDim2.new(1, -2, 0, 40)

local NutTen = TaoNut(
    TrangHienThi,
    "Hien ten nguoi choi: TAT",
    function(Nut)
        TenBat = not TenBat

        Nut.Text = "Hien ten nguoi choi: "
            .. (TenBat and "BAT" or "TAT")

        Nut.BackgroundColor3 =
            TenBat and Mau.Xanh or Mau.Nut

        CapNhatTatCaHienThi()
    end
)

NutTen.Size = UDim2.new(1, -2, 0, 40)

ThemThe(
    TrangHienThi,
    "Hieu ung duoc tao cuc bo, khong thay doi du lieu may chu.",
    60
)

-- Khoi dong
ChuyenTrang("Chinh")
CapNhatDanhSach()
CapNhatMayChu()

local ThoiGian = 0
local KetNoi

KetNoi = RunService.Heartbeat:Connect(function(dt)
    if not GiaoDien.Parent then
        KetNoi:Disconnect()
        return
    end

    if not TuDongBat then
        return
    end

    ThoiGian += dt

    if ThoiGian >= 2 then
        ThoiGian = 0
        CapNhatMayChu()

        if CacTrang.NguoiChoi.Visible then
            CapNhatChiTiet()
        end
    end
end)

GiaoDien.Destroying:Connect(function()
    for _, Nguoi in ipairs(Players:GetPlayers()) do
        if Nguoi.Character then
            XoaHieuUng(Nguoi.Character)
        end
    end
end)
