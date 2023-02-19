-- NOTE: The branches of the if-statement below can be misleading. Since the number of glyphs in Nerd Fonts is constantly growing, vim.g.use_nerd_icons equal to true does not mean that, for example, no glyphs from codicons will be used (BTW, they were added to the Nerd Fonts https://github.com/ryanoasis/nerd-fonts/pull/705). It only means that the majority of the glyphs will be probably coming from earlier releases of Nerd Fonts. This if-statement may disappear in the future as right now I am only relying on the glyphs from Nerd Fonts, anyway.

vim.g.use_nerd_icons = false

if vim.g.use_nerd_icons then
    return {
        kind = {
            Text = "",
            Method = "",
            Function = "",
            Constructor = "",
            Field = "",
            Variable = "",
            Class = "",
            Interface = "",
            Module = "",
            Property = "",
            Unit = "",
            Value = "",
            Enum = "",
            Keyword = "",
            Snippet = "",
            Color = "",
            File = "",
            Reference = "",
            Folder = "",
            EnumMember = "",
            Constant = "",
            Struct = "",
            Event = "",
            Operator = "",
            TypeParameter = "",
            Namespace = "",
            Package = "",
            String = "",
            Number = "",
            Boolean = "",
            Array = "",
            Object = "",
            Key = "",
            Null = "ﳠ",
        },
        git = {
            Repo = "",
            Added = "",
            Modified = "",
            Removed = "",
            Branch = "",
            Unmerged = "",
            Untracked = "★",
        },
        diagnostics = {
            Error = "",
            Warning = "",
            Info = "",
            Hint = "",
            FilledError = "",
            FilledWarning = "",
            FilledInfo = "",
        },
        documents = { Files = "", File = "", PageWithText = "" },
        ui = {
            Cog = "",
            Cogs = " ",
            History = "",
            List = "",
            Leave = "",
            Telescope = "",
            EnterArrow = "",
            BoldArrowRight = "",
            RightChevron = "",
            DownChevron = "",
            DoubleRightChevron = "»",
            NavicRightChevron = ">",
            RightArrow = "➜",
            ThinRightArrow = "➛",
            Symlink = "",
            DirectorySymlink = "",
            OpenedFullFolder = "",
            OpenedEmptyFolder = "",
            ClosedFullFolder = "",
            ClosedEmptyFolder = "",
            Terminal = "",
            Function = "",
            Check = "",
            Fire = "",
            Clock = "",
            Note = "",
            Planet = "◍",
            Stacks = "",
            Scopes = "",
            Watches = "",
            GlowingLightbulb = "󰛨",
        },
        misc = {
            Robot = "ﮧ",
            Package = "",
            Smiley = "ﲃ",
            SmallDot = "",
            VerySmallDot = "•",
            EmptyDot = "◌",
            Bar = "▎",
            LeftThinBar = "▏",
            RightThinBar = " │",
            ThinBar = "│",
            RightTriangleArrow = "",
            Ghost = "",
            Python = "",
            Tree = "",
            Bug = "",
            Pencil = "",
        },
    }
else
    return {
        kind = {
            Text = "",
            Method = "",
            Function = "",
            Constructor = "",
            Field = "",
            Variable = "",
            Class = "",
            Interface = "",
            Module = "",
            Property = "",
            Unit = "",
            Value = "",
            Enum = "",
            Keyword = "",
            Snippet = "",
            Color = "",
            File = "",
            Reference = "",
            Folder = "",
            EnumMember = "",
            Constant = "",
            Struct = "",
            Event = "",
            Operator = "",
            TypeParameter = "",
            Namespace = "",
            Package = "",
            String = "",
            Number = "",
            Boolean = "",
            Array = "",
            Object = "",
            Key = "",
            Null = "",
        },
        git = {
            Repo = "",
            Added = "",
            Modified = "",
            Removed = "",
            Branch = "",
            Unmerged = "",
            Untracked = "★",
        },
        diagnostics = {
            Error = "",
            Warning = "",
            Info = "",
            Question = "",
            Hint = "",
        },
        documents = { Files = "", File = "", PageWithText = "" },
        ui = {
            Cog = "",
            Cogs = " ",
            History = "",
            List = "",
            Leave = "",
            Telescope = "",
            EnterArrow = "",
            BoldArrowRight = "",
            RightChevron = "",
            DownChevron = "",
            DoubleRightChevron = "»",
            NavicRightChevron = ">",
            RightArrow = "➜",
            ThinRightArrow = "➛",
            Symlink = "",
            DirectorySymlink = "",
            OpenedFullFolder = "",
            OpenedEmptyFolder = "",
            ClosedFullFolder = "",
            ClosedEmptyFolder = "",
            Terminal = "",
            Function = "",
            Check = "",
            Fire = "",
            Clock = "",
            Note = "",
            Planet = "◍",
            Stacks = "",
            Scopes = "",
            Watches = "",
            GlowingLightbulb = "󰛨",
        },
        misc = {
            Robot = "ﮧ",
            Package = "",
            Smiley = "",
            SmallDot = "",
            VerySmallDot = "•",
            EmptyDot = "◌",
            Bar = "▎",
            LeftThinBar = "▏",
            RightThinBar = " │",
            ThinBar = "│",
            RightTriangleArrow = "",
            Ghost = "",
            Python = "",
            Tree = "",
            Bug = "",
            Pencil = "",
        },
    }
end
