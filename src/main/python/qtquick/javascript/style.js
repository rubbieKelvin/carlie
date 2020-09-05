const Colors = {
        Light: {
                BG:     "#ffffff",
                Red:    "#FF3B30",
                Orange: "#FF9500",
                Yellow: "#FFCC00",
                Green:  "#27AE60",
                Teal:   "#5AC8FA",
                Blue:   "#421bb6",
                Indigo: "#5856D6",
                Purple: "#AF52DE",
                Pink:   "#FF2D55",
                Gray1:  "#8E8E93",
                Gray2:  "#AEAEB2",
                Gray3:  "#C7C7CC",
                Gray4:  "#D1D1D6",
                Gray5:  "#E5E5EA",
                Gray6:  "#F2F2F7",
                Text:   "#000000"
        },
        Dark: {
                BG:     "#292929",
                Red:    "#FF453A",
                Orange: "#FF9F0A",
                Yellow: "#FFD60A",
                Green:  "#32D74B",
                Teal:   "#64D2FF",
                Blue:   "#0A84FF",
                Indigo: "#5E5CE6",
                Purple: "#BF5AF2",
                Pink:   "#FF2D55",
                Gray1:  "#8E8E93",
                Gray2:  "#636366",
                Gray3:  "#48484A",
                Gray4:  "#3A3A3C",
                Gray5:  "#2C2C2E",
                Gray6:  "#1C1C1E",
                Text:   "#ffffff"
        }
};

const Theme = {
        Light: "Light",
        Dark: "Dark"
};

const color = (colorcode, theme) => Colors[theme][colorcode];