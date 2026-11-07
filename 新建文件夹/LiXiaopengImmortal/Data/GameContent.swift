import Foundation

enum GameContent {
    static let defaultRelationships: [Relationship] = [
        Relationship(id: "lin", name: "林晚晴", age: 25, title: "仁心医者", symbol: "cross.case.fill", affection: 0, unlocked: false, lastMemory: "尚未相遇"),
        Relationship(id: "su", name: "苏清寒", age: 27, title: "冰山总裁", symbol: "building.2.fill", affection: 0, unlocked: false, lastMemory: "尚未相遇"),
        Relationship(id: "shen", name: "沈星璃", age: 24, title: "特别调查员", symbol: "shield.lefthalf.filled", affection: 0, unlocked: false, lastMemory: "尚未相遇"),
        Relationship(id: "jiang", name: "江雨柔", age: 26, title: "国民歌手", symbol: "music.mic", affection: 0, unlocked: false, lastMemory: "尚未相遇")
    ]

    static let defaultInventory: [InventoryItem] = [
        InventoryItem(id: "jade", name: "无名古玉", description: "师父留下的古玉，内部似乎封印着一方世界。", rarity: "神话", symbol: "diamond.fill", quantity: 1),
        InventoryItem(id: "needle", name: "太玄金针", description: "一念生、一念死，可医凡人，也可断仙途。", rarity: "仙品", symbol: "wand.and.stars", quantity: 1),
        InventoryItem(id: "phone", name: "旧手机", description: "屏幕有一道裂纹，却保存着李晓鹏回到江城后的全部联系。", rarity: "普通", symbol: "iphone", quantity: 1),
        InventoryItem(id: "spiritstone", name: "极品灵石", description: "灵气纯净得不似此界之物。", rarity: "珍稀", symbol: "hexagon.fill", quantity: 0),
        InventoryItem(id: "blackcard", name: "天阙黑卡", description: "全球不限额，持卡者身份不详。", rarity: "传说", symbol: "creditcard.fill", quantity: 0),
        InventoryItem(id: "starbadge", name: "星盾徽章", description: "特别调查局最高权限徽章。", rarity: "传说", symbol: "star.shield.fill", quantity: 0),
        InventoryItem(id: "sword", name: "九霄剑", description: "剑未出鞘，天下剑修已俯首。", rarity: "神话", symbol: "bolt.fill", quantity: 0),
        InventoryItem(id: "ticket", name: "雨柔演唱会票", description: "第一排中央席，背面有一行手写小字。", rarity: "纪念", symbol: "ticket.fill", quantity: 0)
    ]

    static let defaultQuests: [Quest] = [
        Quest(id: "return", title: "王者归来", detail: "隐藏身份回到江城，查清李家旧宅被夺的真相。", reward: "声望 +20、天阙黑卡", status: .active),
        Quest(id: "clinic", title: "医者仁心", detail: "帮助林晚晴解决医院里的诡异灵毒。", reward: "林晚晴羁绊、太玄丹", status: .locked),
        Quest(id: "company", title: "清寒之危", detail: "保住苏氏集团，揪出董事会内鬼。", reward: "苏清寒羁绊、灵石矿线索", status: .locked),
        Quest(id: "auction", title: "暗夜拍卖会", detail: "调查地下拍卖会与血煞宗的交易。", reward: "沈星璃羁绊、星盾徽章", status: .locked),
        Quest(id: "mountain", title: "云山风云", detail: "在云山秘境开启前救出被盯上的江雨柔。", reward: "江雨柔羁绊、九霄剑", status: .locked),
        Quest(id: "capital", title: "一人压一城", detail: "赴京城，让四大世家为当年之事付出代价。", reward: "境界显露、天下震动", status: .locked),
        Quest(id: "rift", title: "诸天裂隙", detail: "关闭降临都市上空的裂隙，决定这个世界的未来。", reward: "最终结局", status: .locked)
    ]

    static let nodes: [String: StoryNode] = Dictionary(uniqueKeysWithValues: allNodes.map { ($0.id, $0) })

    static func node(_ id: String) -> StoryNode? { nodes[id] }

    private static let allNodes: [StoryNode] = [
        StoryNode(
            id: "c1_arrival", chapter: 1, chapterTitle: "王者归来", location: "江城高铁站",
            title: "仙尊下山",
            body: "十年昆仑，一朝归来。李晓鹏穿着洗得发白的外套走出车站，身后没有随从，兜里只有两万元和一块无名古玉。没有人知道，三日前横压海外七十二神殿的神秘仙尊，正是眼前这个二十四岁的青年。\n\n出口处，一辆失控的豪车撞向人群。所有人都在逃，只有一名穿白裙的女孩逆着人流冲过去，试图拉开被吓呆的孩子。",
            speaker: nil, mood: "晨光",
            choices: [
                StoryChoice(id: "c1a", title: "弹指停车", subtitle: "不装了？只露一丝力量就够。", symbol: "hand.raised.fill", nextNodeID: "c1_rescue", effect: GameEffect(reputation: 3, swagger: 8, setFlags: ["public_rescue"], toast: "全场寂静：他用一根手指按停了跑车")),
                StoryChoice(id: "c1b", title: "暗中出手", subtitle: "让女孩以为只是侥幸。", symbol: "eye.slash.fill", nextNodeID: "c1_rescue", effect: GameEffect(qi: -1, swagger: 4, setFlags: ["hidden_rescue"], toast: "无人发现那缕托住车身的灵气")),
                StoryChoice(id: "c1c", title: "先救孩子再算账", subtitle: "顺便记住肇事者的气息。", symbol: "figure.run", nextNodeID: "c1_rescue", effect: GameEffect(reputation: 1, swagger: 5, setFlags: ["track_driver"], toast: "血煞气息——这不是普通事故"))
            ]
        ),
        StoryNode(
            id: "c1_rescue", chapter: 1, chapterTitle: "王者归来", location: "站前广场",
            title: "第一次相遇",
            body: "女孩名叫林晚晴，是江城第一医院最年轻的主治医师。她确认孩子平安后才发现，李晓鹏的手掌正抵在变形的引擎盖上，神情却像只是扶住了一扇门。\n\n“你受伤了吗？跟我去医院检查。”她认真地拉住他的袖口。远处，豪车司机王浩爬出来，非但没有道歉，反而指着二人破口大骂。",
            speaker: "林晚晴", mood: "心跳",
            choices: [
                StoryChoice(id: "c1d", title: "先答应她", subtitle: "有人关心的感觉，似乎不坏。", symbol: "heart.fill", nextNodeID: "c1_clinic", effect: GameEffect(relationshipID: "lin", affection: 12, unlockRelationshipID: "lin", questID: "clinic", questStatus: .active, setFlags: ["lin_promised"], toast: "解锁红颜：林晚晴")),
                StoryChoice(id: "c1e", title: "让王浩道歉", subtitle: "三秒之内，否则后果自负。", symbol: "exclamationmark.bubble.fill", nextNodeID: "c1_driver", effect: GameEffect(reputation: 4, swagger: 10, relationshipID: "lin", affection: 6, unlockRelationshipID: "lin", toast: "倒计时开始"))
            ]
        ),
        StoryNode(
            id: "c1_driver", chapter: 1, chapterTitle: "王者归来", location: "站前广场",
            title: "豪门少爷？跪下",
            body: "王浩报出江城王家的名号，围观者纷纷后退。李晓鹏只看了他一眼，那道曾令万兽俯首的威压便落在他肩头。\n\n“三。”\n\n还没数到二，王浩双膝砸地，当众向孩子和林晚晴磕头。直播间里，弹幕瞬间刷屏。李晓鹏却已经转身，仿佛碾过的只是一粒灰尘。",
            speaker: "李晓鹏", mood: "震慑",
            choices: [
                StoryChoice(id: "c1f", title: "陪晚晴去医院", subtitle: "医院里有一股不寻常的阴气。", symbol: "cross.case.fill", nextNodeID: "c1_clinic", effect: GameEffect(relationshipID: "lin", affection: 7, questID: "clinic", questStatus: .active, setFlags: ["wang_humiliated"]))
            ]
        ),
        StoryNode(
            id: "c1_clinic", chapter: 1, chapterTitle: "王者归来", location: "江城第一医院",
            title: "一针惊世",
            body: "检查刚结束，急诊室便传来警报。地产大亨赵东海心脏骤停，省城专家束手无策。院长见李晓鹏一身普通，厉声让保安赶人。林晚晴却挡在他身前：“他刚才救过一整车人，我信他。”\n\n李晓鹏扫了一眼病床。不是心脏病，而是一缕附骨灵毒。对他而言，解毒只需一针。",
            speaker: "林晚晴", mood: "紧张",
            choices: [
                StoryChoice(id: "c1g", title: "金针渡命", subtitle: "让所谓专家见识真正的医道。", symbol: "wand.and.stars", nextNodeID: "c1_banquet", effect: GameEffect(qi: -2, money: 1_000_000, reputation: 12, swagger: 12, relationshipID: "lin", affection: 12, questID: "clinic", questStatus: .completed, setFlags: ["saved_zhao"], toast: "赵东海奉上一百万诊金")),
                StoryChoice(id: "c1h", title: "教晚晴施针", subtitle: "功劳归她，锋芒暂藏。", symbol: "person.2.fill", nextNodeID: "c1_banquet", effect: GameEffect(qi: -1, money: 200_000, reputation: 5, swagger: 7, relationshipID: "lin", affection: 18, questID: "clinic", questStatus: .completed, setFlags: ["taught_lin"], toast: "林晚晴记住了你握针时的温度"))
            ]
        ),
        StoryNode(
            id: "c1_banquet", chapter: 1, chapterTitle: "王者归来", location: "云顶酒店",
            title: "旧宅之宴",
            body: "赵东海为谢救命之恩设下晚宴。巧的是，王家正好也在这里庆祝吞并李家旧宅。十年前落井下石的亲戚们认出李晓鹏，笑他混得连一身西装都买不起。\n\n王家家主拍出地契：“想拿回旧宅？跪下敬三杯，我或许让你进去看一眼。”整个宴会厅都等着看笑话。",
            speaker: "王家家主", mood: "鸿门宴",
            choices: [
                StoryChoice(id: "c1i", title: "亮出天阙令", subtitle: "全球财团负责人集体起立。", symbol: "crown.fill", nextNodeID: "c2_boardroom", effect: GameEffect(reputation: 15, swagger: 18, addItemID: "blackcard", addItemQuantity: 1, questID: "return", questStatus: .completed, setFlags: ["revealed_tianque"], toast: "王家资产被冻结，旧宅物归原主")),
                StoryChoice(id: "c1j", title: "一元买下王家", subtitle: "先让他们笑，再让律师宣读收购书。", symbol: "banknote.fill", nextNodeID: "c2_boardroom", effect: GameEffect(money: -1, reputation: 12, swagger: 20, addItemID: "blackcard", addItemQuantity: 1, questID: "return", questStatus: .completed, setFlags: ["bought_wang"], toast: "从今天起，王家替你看门"))
            ]
        ),

        StoryNode(
            id: "c2_boardroom", chapter: 2, chapterTitle: "冰山总裁", location: "苏氏集团",
            title: "被拒之门外的贵客",
            body: "第二天，赵东海请李晓鹏替他参加苏氏集团的投资会。前台见他没有预约，把他晾在大厅。此时电梯门打开，一身黑色职业装的苏清寒快步走出。她是苏家掌舵人，也是江城商界最难接近的女人。\n\n董事长叔父在身后冷笑：“清寒，别什么穷亲戚都往公司领。今天拿不到投资，你就交出总裁位置。”",
            speaker: "苏清寒", mood: "冷冽",
            choices: [
                StoryChoice(id: "c2a", title: "坐上主位", subtitle: "告诉所有人：投资人已经到了。", symbol: "chair.lounge.fill", nextNodeID: "c2_invest", effect: GameEffect(reputation: 4, swagger: 10, relationshipID: "su", affection: 8, unlockRelationshipID: "su", questID: "company", questStatus: .active, toast: "解锁红颜：苏清寒")),
                StoryChoice(id: "c2b", title: "继续装普通人", subtitle: "看看谁会在此刻站到她身边。", symbol: "person.fill.questionmark", nextNodeID: "c2_test", effect: GameEffect(swagger: 5, relationshipID: "su", affection: 5, unlockRelationshipID: "su", questID: "company", questStatus: .active))
            ]
        ),
        StoryNode(
            id: "c2_test", chapter: 2, chapterTitle: "冰山总裁", location: "董事会议室",
            title: "她选择相信",
            body: "满桌董事没有一个人给李晓鹏留座。苏清寒却亲自把自己的椅子推到他身边，还为他倒了一杯茶。\n\n“就算投资失败，他也是我的客人。”\n\n李晓鹏抬眸。十年间，无数人敬畏他的力量，眼前这个女人却在不知道他是谁时，依然给了他尊重。",
            speaker: "苏清寒", mood: "信任",
            choices: [
                StoryChoice(id: "c2c", title: "不再让她独撑", subtitle: "天阙资本，投资一百亿。", symbol: "infinity", nextNodeID: "c2_invest", effect: GameEffect(reputation: 8, relationshipID: "su", affection: 15, setFlags: ["su_trust_first"], toast: "冰山般的眼眸第一次泛起波澜"))
            ]
        ),
        StoryNode(
            id: "c2_invest", chapter: 2, chapterTitle: "冰山总裁", location: "董事会议室",
            title: "百亿只是零花钱",
            body: "董事们哄堂大笑，直到天阙资本亚洲区负责人带着律师团推门而入，对李晓鹏九十度鞠躬。大屏幕上的首笔十亿资金实时到账。\n\n苏家叔父脸色惨白，却偷偷启动了藏在会议桌下的噬魂阵。普通商业争斗背后，竟有修士插手。李晓鹏轻敲桌面，整座阵法瞬间倒转。",
            speaker: "天阙负责人", mood: "反转",
            choices: [
                StoryChoice(id: "c2d", title: "让内鬼自曝", subtitle: "阵法会让说谎者吐露真相。", symbol: "waveform.path.ecg", nextNodeID: "c2_rooftop", effect: GameEffect(qi: -2, reputation: 10, swagger: 15, relationshipID: "su", affection: 8, questID: "company", questStatus: .completed, setFlags: ["caught_traitor"], toast: "董事会内鬼当众认罪")),
                StoryChoice(id: "c2e", title: "顺藤摸瓜", subtitle: "暂时放走内鬼，锁定幕后修士。", symbol: "scope", nextNodeID: "c2_rooftop", effect: GameEffect(qi: -1, swagger: 10, relationshipID: "su", affection: 5, questID: "company", questStatus: .completed, setFlags: ["tracked_cultivator"], toast: "线索指向今晚的地下拍卖会"))
            ]
        ),
        StoryNode(
            id: "c2_rooftop", chapter: 2, chapterTitle: "冰山总裁", location: "苏氏天台",
            title: "城市与晚风",
            body: "危机解除后，苏清寒在天台找到李晓鹏。她脱下高跟鞋坐在栏杆边，第一次显出疲惫。\n\n“所有人都想从我这里得到什么。只有你，像是什么都不缺。”\n\n夜风掠过她的长发。远处霓虹万丈，而她只等他的回答。",
            speaker: "苏清寒", mood: "夜色",
            choices: [
                StoryChoice(id: "c2f", title: "我缺一个同行的人", subtitle: "向她伸出手。", symbol: "hand.point.up.left.fill", nextNodeID: "c3_invitation", effect: GameEffect(relationshipID: "su", affection: 14, setFlags: ["su_rooftop_promise"], toast: "苏清寒把手放进你的掌心")),
                StoryChoice(id: "c2g", title: "替她披上外套", subtitle: "有些回答，不必说出口。", symbol: "wind", nextNodeID: "c3_invitation", effect: GameEffect(relationshipID: "su", affection: 10, setFlags: ["su_rooftop_coat"]))
            ]
        ),

        StoryNode(
            id: "c3_invitation", chapter: 3, chapterTitle: "暗夜拍卖", location: "李家旧宅",
            title: "来自星盾的邀请",
            body: "深夜，一枚刻着星纹的飞刀钉在院门上。黑衣女子翻墙落地，亮出特别调查局证件。她叫沈星璃，二十四岁，专门处理都市中的超自然案件。\n\n“地下拍卖会正在交易活人魂魄。我的搭档失踪了。你在医院和苏氏留下的灵力痕迹，骗得过别人，骗不过我。”她口中的试探很锋利，握刀的手却因旧伤微微发抖。",
            speaker: "沈星璃", mood: "试探",
            choices: [
                StoryChoice(id: "c3a", title: "替她治伤", subtitle: "隔空点穴，旧伤顷刻痊愈。", symbol: "cross.vial.fill", nextNodeID: "c3_auction", effect: GameEffect(qi: -1, relationshipID: "shen", affection: 14, unlockRelationshipID: "shen", questID: "auction", questStatus: .active, toast: "解锁红颜：沈星璃")),
                StoryChoice(id: "c3b", title: "先谈条件", subtitle: "行动结束后，星盾欠你一个人情。", symbol: "text.bubble.fill", nextNodeID: "c3_auction", effect: GameEffect(reputation: 3, relationshipID: "shen", affection: 7, unlockRelationshipID: "shen", questID: "auction", questStatus: .active, setFlags: ["starshield_favor"]))
            ]
        ),
        StoryNode(
            id: "c3_auction", chapter: 3, chapterTitle: "暗夜拍卖", location: "地下拍卖场",
            title: "你管这叫法器？",
            body: "拍卖会藏在废弃地铁站下。各方豪强争抢一块所谓的“上古神石”，价格很快抬到三亿。李晓鹏却看出，那只是自己十年前随手丢掉的一块练功废料。\n\n血煞宗少主见沈星璃戴着面具仍气质出众，故意将竞价牌拍在她面前：“陪本少喝一杯，神石送你。”全场无人敢出声。",
            speaker: "血煞少主", mood: "暗潮",
            choices: [
                StoryChoice(id: "c3c", title: "十块钱，我要了", subtitle: "不是竞价，是给卖家留点面子。", symbol: "10.circle.fill", nextNodeID: "c3_slap", effect: GameEffect(money: -10, swagger: 15, relationshipID: "shen", affection: 6, addItemID: "spiritstone", addItemQuantity: 1, setFlags: ["auction_bid"])),
                StoryChoice(id: "c3d", title: "捏碎神石", subtitle: "告诉他们什么才叫极品灵石。", symbol: "burst.fill", nextNodeID: "c3_slap", effect: GameEffect(qi: 20, reputation: 8, swagger: 18, relationshipID: "shen", affection: 8, setFlags: ["crushed_fake"], toast: "废石成灰，灵气化龙"))
            ]
        ),
        StoryNode(
            id: "c3_slap", chapter: 3, chapterTitle: "暗夜拍卖", location: "地下拍卖场",
            title: "一掌灭宗师",
            body: "血煞少主召来三名武道宗师。主持人封死出口，数百宾客以为李晓鹏必死无疑。\n\n李晓鹏甚至没有起身，只把茶杯轻轻放回桌面。水面荡开一圈涟漪，三名宗师同时倒飞，墙上留下三个整齐的人形凹痕。\n\n“我不喜欢别人站着威胁我的朋友。”",
            speaker: "李晓鹏", mood: "碾压",
            choices: [
                StoryChoice(id: "c3e", title: "覆灭拍卖会", subtitle: "救出所有被囚禁的人。", symbol: "flame.fill", nextNodeID: "c3_escape", effect: GameEffect(qi: -3, reputation: 15, swagger: 16, relationshipID: "shen", affection: 12, addItemID: "starbadge", addItemQuantity: 1, questID: "auction", questStatus: .completed, setFlags: ["saved_captives"], toast: "星盾授予你最高权限")),
                StoryChoice(id: "c3f", title: "命他们反攻血煞宗", subtitle: "恶人自食其果，顺便钓出幕后人。", symbol: "arrow.triangle.branch", nextNodeID: "c3_escape", effect: GameEffect(reputation: 8, swagger: 20, relationshipID: "shen", affection: 8, addItemID: "starbadge", addItemQuantity: 1, questID: "auction", questStatus: .completed, setFlags: ["turned_auction"]))
            ]
        ),
        StoryNode(
            id: "c3_escape", chapter: 3, chapterTitle: "暗夜拍卖", location: "江畔",
            title: "并肩看日出",
            body: "行动结束时天已微亮。沈星璃坐在江堤上，把珍藏多年的星盾徽章塞进李晓鹏掌心。她一直习惯独自行动，今夜却第一次把后背交给另一个人。\n\n“李晓鹏，下次别冲那么快。”她别过脸，“不是担心你，我只是……不想写伤亡报告。”",
            speaker: "沈星璃", mood: "破晓",
            choices: [
                StoryChoice(id: "c3g", title: "下次一起", subtitle: "替她拨开被风吹乱的头发。", symbol: "sunrise.fill", nextNodeID: "c4_concert", effect: GameEffect(relationshipID: "shen", affection: 14, questID: "mountain", questStatus: .active, setFlags: ["shen_dawn"])),
                StoryChoice(id: "c3h", title: "你写，我负责无敌", subtitle: "一句话把她逗笑。", symbol: "face.smiling.fill", nextNodeID: "c4_concert", effect: GameEffect(swagger: 5, relationshipID: "shen", affection: 10, questID: "mountain", questStatus: .active))
            ]
        ),

        StoryNode(
            id: "c4_concert", chapter: 4, chapterTitle: "云山风云", location: "江城体育馆",
            title: "歌声里的求救",
            body: "国民歌手江雨柔的演唱会座无虚席。李晓鹏本无意追星，却从歌声中听到了一道只有修士才能察觉的求救神念。\n\n灯架突然坠落，台下尖叫四起。江雨柔没有逃，而是护住身旁的小舞者。李晓鹏一步踏过数十米，接住千斤钢架，也接住从舞台跌下的她。全场灯光恰在此刻聚拢。",
            speaker: "江雨柔", mood: "聚光灯",
            choices: [
                StoryChoice(id: "c4a", title: "公主抱落地", subtitle: "既然万众瞩目，就帅到底。", symbol: "figure.dance", nextNodeID: "c4_backstage", effect: GameEffect(reputation: 15, swagger: 18, relationshipID: "jiang", affection: 12, unlockRelationshipID: "jiang", toast: "解锁红颜：江雨柔")),
                StoryChoice(id: "c4b", title: "隐去身形", subtitle: "救下她后消失在灯影中。", symbol: "sparkles", nextNodeID: "c4_backstage", effect: GameEffect(qi: -2, swagger: 10, relationshipID: "jiang", affection: 8, unlockRelationshipID: "jiang", setFlags: ["mysterious_savior"]))
            ]
        ),
        StoryNode(
            id: "c4_backstage", chapter: 4, chapterTitle: "云山风云", location: "演唱会后台",
            title: "她认识那块古玉",
            body: "后台，江雨柔屏退经纪人，取出一枚与无名古玉同源的玉坠。她幼时曾在云山失踪三天，醒来后便能在梦里听见山中有人呼唤。最近，那声音变成了威胁。\n\n“他们说，如果我不去云山，就会伤害所有来看演唱会的人。”她摘下光芒万丈的明星面具，此刻只是一个害怕牵连他人的女孩。",
            speaker: "江雨柔", mood: "秘密",
            choices: [
                StoryChoice(id: "c4c", title: "我陪你去", subtitle: "从现在起，没人能威胁你。", symbol: "shield.fill", nextNodeID: "c4_mountain", effect: GameEffect(relationshipID: "jiang", affection: 15, addItemID: "ticket", addItemQuantity: 1, setFlags: ["jiang_promise"], toast: "她把专属门票放进你手心")),
                StoryChoice(id: "c4d", title: "让敌人来找我", subtitle: "以古玉为饵，反客为主。", symbol: "target", nextNodeID: "c4_mountain", effect: GameEffect(swagger: 8, relationshipID: "jiang", affection: 10, addItemID: "ticket", addItemQuantity: 1, setFlags: ["jade_bait"]))
            ]
        ),
        StoryNode(
            id: "c4_mountain", chapter: 4, chapterTitle: "云山风云", location: "云山之巅",
            title: "万剑朝宗",
            body: "云山秘境开启，十几个隐世宗门齐聚。剑宗圣子指名要江雨柔献出血脉，并嘲笑李晓鹏没有半点修为。\n\n“凡人也配登云山？”\n\n李晓鹏向前一步。整座剑冢中的万柄古剑同时出鞘，悬在他身后，剑尖尽数朝下——那不是进攻，而是臣服。沉睡千年的九霄剑破山而出，主动落入他手中。",
            speaker: "剑宗圣子", mood: "万剑齐鸣",
            choices: [
                StoryChoice(id: "c4e", title: "剑压诸宗", subtitle: "让所有人向雨柔道歉。", symbol: "bolt.fill", nextNodeID: "c4_campfire", effect: GameEffect(qi: -5, reputation: 20, swagger: 25, relationshipID: "jiang", affection: 12, addItemID: "sword", addItemQuantity: 1, questID: "mountain", questStatus: .completed, setFlags: ["sword_submission"], toast: "万宗俯首，九霄认主")),
                StoryChoice(id: "c4f", title: "封掉他们修为", subtitle: "让高高在上的修士体验凡人的一天。", symbol: "lock.fill", nextNodeID: "c4_campfire", effect: GameEffect(qi: -3, reputation: 14, swagger: 28, relationshipID: "jiang", affection: 10, addItemID: "sword", addItemQuantity: 1, questID: "mountain", questStatus: .completed, setFlags: ["sealed_sects"]))
            ]
        ),
        StoryNode(
            id: "c4_campfire", chapter: 4, chapterTitle: "云山风云", location: "云海营地",
            title: "只唱给一个人",
            body: "众人退去，江雨柔坐在篝火旁，为李晓鹏唱了一首从未发表的歌。没有舞台、没有伴奏，只有云海与星光。\n\n曲终，她轻声问：“如果有一天我不再是明星，你还会听我唱歌吗？”",
            speaker: "江雨柔", mood: "星火",
            choices: [
                StoryChoice(id: "c4g", title: "你的歌，与身份无关", subtitle: "约定每年都来云山听一次。", symbol: "music.note", nextNodeID: "c5_summons", effect: GameEffect(relationshipID: "jiang", affection: 16, setFlags: ["jiang_song"])),
                StoryChoice(id: "c4h", title: "那就只唱给我听", subtitle: "她红着脸点了点头。", symbol: "heart.circle.fill", nextNodeID: "c5_summons", effect: GameEffect(swagger: 5, relationshipID: "jiang", affection: 18, setFlags: ["jiang_private_song"]))
            ]
        ),

        StoryNode(
            id: "c5_summons", chapter: 5, chapterTitle: "一人压京城", location: "江城·李家旧宅",
            title: "来自京城的战书",
            body: "四大世家联名送来战书，要求李晓鹏三日内赴京请罪。原来十年前李家遇难，正是因为父亲拒绝交出无名古玉。\n\n林晚晴、苏清寒、沈星璃与江雨柔不约而同来到旧宅。她们都知道京城此行凶险，却没有一个人劝他退缩。",
            speaker: nil, mood: "同心",
            choices: [
                StoryChoice(id: "c5a", title: "独自赴京", subtitle: "这一次，由我保护所有人。", symbol: "airplane.departure", nextNodeID: "c5_gate", effect: GameEffect(swagger: 10, questID: "capital", questStatus: .active, setFlags: ["went_alone"])),
                StoryChoice(id: "c5b", title: "与她们并肩", subtitle: "无敌不是孤独，而是护住同行的人。", symbol: "person.3.fill", nextNodeID: "c5_gate", effect: GameEffect(reputation: 5, relationshipID: "lin", affection: 4, questID: "capital", questStatus: .active, setFlags: ["team_capital"]))
            ]
        ),
        StoryNode(
            id: "c5_gate", chapter: 5, chapterTitle: "一人压京城", location: "京城武盟总会",
            title: "门槛太低，我抬一抬",
            body: "武盟门前聚集了全国宗师，四大世家更请来闭关百年的元婴老祖。守门人故意摆出测力石，宣称力量不足十万斤者不配入内。\n\n李晓鹏屈指一弹。测力石没有碎，而是缓缓升入高空，化作第二轮月亮，照亮整座京城。\n\n“十万斤的门槛，确实低了些。”",
            speaker: "李晓鹏", mood: "举城皆惊",
            choices: [
                StoryChoice(id: "c5c", title: "踏门而入", subtitle: "每走一步，便有一位宗师跪下。", symbol: "shoeprints.fill", nextNodeID: "c5_truth", effect: GameEffect(qi: -3, reputation: 25, swagger: 30, realmChange: 3, setFlags: ["moon_stone"], toast: "显露境界：元婴")),
                StoryChoice(id: "c5d", title: "让他们出来迎接", subtitle: "三声之后，武盟大门自行崩解。", symbol: "bell.and.waves.left.and.right.fill", nextNodeID: "c5_truth", effect: GameEffect(qi: -2, reputation: 22, swagger: 32, realmChange: 3, setFlags: ["shattered_gate"], toast: "四大家主列队迎接"))
            ]
        ),
        StoryNode(
            id: "c5_truth", chapter: 5, chapterTitle: "一人压京城", location: "武盟天牢",
            title: "十年前的真相",
            body: "天牢深处，李晓鹏找到了本该在十年前死去的父亲。四大世家用锁灵链囚禁他，只为逼问古玉的秘密。\n\n父亲说，古玉是封住诸天裂隙的钥匙。京城世家背后的血煞宗一直想打开裂隙，迎接所谓上界仙使。如今封印已松，天空开始出现第二道太阳。",
            speaker: "父亲", mood: "真相",
            choices: [
                StoryChoice(id: "c5e", title: "先救父亲", subtitle: "一念断尽锁灵链，十年苦难到此为止。", symbol: "link.badge.plus", nextNodeID: "c5_judgment", effect: GameEffect(qi: -5, reputation: 10, setFlags: ["father_saved"], toast: "父子重逢")),
                StoryChoice(id: "c5f", title: "让世家亲自开锁", subtitle: "每拖一秒，便废一位老祖修为。", symbol: "key.fill", nextNodeID: "c5_judgment", effect: GameEffect(reputation: 15, swagger: 25, setFlags: ["families_unlocked"], toast: "四大家主争相献上钥匙"))
            ]
        ),
        StoryNode(
            id: "c5_judgment", chapter: 5, chapterTitle: "一人压京城", location: "京城之巅",
            title: "该跪的不是我",
            body: "血煞宗主借裂隙之力降临，气息压得全城喘不过气。他命李晓鹏交出古玉，并许诺封他为人间之王。\n\n李晓鹏只问了一个问题：“你也配封我？”\n\n九霄剑出鞘半寸，血煞宗主的法相便从中裂开。四大世家的倚仗，在他面前连一剑都接不住。",
            speaker: "李晓鹏", mood: "审判",
            choices: [
                StoryChoice(id: "c5g", title: "废其修为，交给星盾", subtitle: "让法律清算每一桩罪。", symbol: "scalemass.fill", nextNodeID: "c6_rift", effect: GameEffect(qi: -5, reputation: 25, swagger: 20, relationshipID: "shen", affection: 10, questID: "capital", questStatus: .completed, setFlags: ["legal_judgment"], toast: "京城旧秩序终结")),
                StoryChoice(id: "c5h", title: "一剑斩断因果", subtitle: "血煞传承自此从世间抹去。", symbol: "bolt.horizontal.fill", nextNodeID: "c6_rift", effect: GameEffect(qi: -8, reputation: 20, swagger: 30, questID: "capital", questStatus: .completed, setFlags: ["bloodsect_erased"], toast: "天下再无血煞宗"))
            ]
        ),

        StoryNode(
            id: "c6_rift", chapter: 6, chapterTitle: "诸天裂隙", location: "江城上空",
            title: "天门开启",
            body: "血煞宗虽灭，诸天裂隙却彻底张开。巨大的天门横跨城市上空，自称上界巡天使的男人踏云而来，身后是遮天蔽日的仙兵。\n\n全世界的镜头对准江城。巡天使宣布人间将成为上界灵田，并给众生十分钟跪拜。李晓鹏在亿万人注视下缓缓升空。",
            speaker: "巡天使", mood: "末日",
            choices: [
                StoryChoice(id: "c6a", title: "让他先出三招", subtitle: "站着不动，衣角都不许乱。", symbol: "3.circle.fill", nextNodeID: "c6_three", effect: GameEffect(swagger: 25, questID: "rift", questStatus: .active, setFlags: ["three_moves"])),
                StoryChoice(id: "c6b", title: "一巴掌拍回天门", subtitle: "谁给你的勇气俯视人间？", symbol: "hand.raised.fingers.spread.fill", nextNodeID: "c6_reveal", effect: GameEffect(qi: -10, reputation: 30, swagger: 35, questID: "rift", questStatus: .active, setFlags: ["slapped_envoy"], toast: "巡天使被拍回上界"))
            ]
        ),
        StoryNode(
            id: "c6_three", chapter: 6, chapterTitle: "诸天裂隙", location: "万米高空",
            title: "三招已过",
            body: "第一招焚天，李晓鹏低头回了林晚晴一条消息。第二招碎星，他替苏清寒签完一份电子合同。第三招万剑归墟，他接通江雨柔的视频，让她看了一场高空烟花。\n\n沈星璃在指挥中心忍不住笑出声：“他甚至还没开始。”\n\n烟尘散尽，李晓鹏果然连衣角都没有乱。",
            speaker: "全球直播", mood: "名场面",
            choices: [
                StoryChoice(id: "c6c", title: "现在轮到我", subtitle: "只出一根手指。", symbol: "hand.point.up.fill", nextNodeID: "c6_reveal", effect: GameEffect(reputation: 35, swagger: 40, relationshipID: "lin", affection: 5, toast: "全球爽点突破天际"))
            ]
        ),
        StoryNode(
            id: "c6_reveal", chapter: 6, chapterTitle: "诸天裂隙", location: "天门之前",
            title: "至尊归位",
            body: "巡天使捏碎上界帝符，召来仙帝投影。那投影看清李晓鹏的脸后，却像见到最可怕的存在，当场跪伏。\n\n“三千年前横压诸天、令万界共尊的那个人……您回来了。”\n\n李晓鹏不再隐藏。九重至尊神环照彻星河，所有被压制的灵脉同时复苏。他从来不是什么新晋修士，而是轮回归来的诸天至尊。",
            speaker: "仙帝投影", mood: "至尊",
            choices: [
                StoryChoice(id: "c6d", title: "封闭天门", subtitle: "人间命运，只能由人间决定。", symbol: "door.left.hand.closed", nextNodeID: "c7_choice", effect: GameEffect(qi: 100, reputation: 50, swagger: 50, realmChange: 8, setFlags: ["closed_gate"], toast: "真实境界：诸天至尊")),
                StoryChoice(id: "c6e", title: "反攻上界", subtitle: "带着众生去看看，仙凭什么高高在上。", symbol: "arrow.up.forward.circle.fill", nextNodeID: "c7_choice", effect: GameEffect(qi: 100, reputation: 45, swagger: 60, realmChange: 8, setFlags: ["conquered_heaven"], toast: "天门之后，万仙列队"))
            ]
        ),

        StoryNode(
            id: "c7_choice", chapter: 7, chapterTitle: "人间值得", location: "重建后的江城",
            title: "无敌之后",
            body: "天门风波过去一年，都市与修仙不再是彼此隐瞒的秘密。李晓鹏把功法公开给所有人，却设下不可逾越的规则：力量不能成为欺凌弱者的理由。\n\n林晚晴建立修真医院，苏清寒推动灵能科技，沈星璃重组星盾，江雨柔用歌声安抚灵气复苏后的众生。她们都在各自的道路上闪耀，也都把一把钥匙留给了他。",
            speaker: nil, mood: "新世界",
            choices: [
                StoryChoice(id: "c7a", title: "赴四人之约", subtitle: "真正的羁绊，从不是把谁藏在身后。", symbol: "heart.text.square.fill", nextNodeID: "c7_promises", effect: GameEffect(relationshipID: "su", affection: 5, questID: "rift", questStatus: .completed, setFlags: ["all_promises"])),
                StoryChoice(id: "c7b", title: "先回李家旧宅", subtitle: "今晚，所有重要的人都会到齐。", symbol: "house.fill", nextNodeID: "c7_promises", effect: GameEffect(relationshipID: "jiang", affection: 5, questID: "rift", questStatus: .completed, setFlags: ["home_feast"]))
            ]
        ),
        StoryNode(
            id: "c7_promises", chapter: 7, chapterTitle: "人间值得", location: "江城夜色",
            title: "四份心意",
            body: "林晚晴把医院天台的晚餐排在六点，苏清寒预约了七点的江畔游船，沈星璃的任务结束时间写着八点，江雨柔则把新歌首听会定在九点。四条消息几乎同时亮起。\n\n李晓鹏看着严丝合缝的时间表，第一次觉得诸天至尊也会遇到难题。可他没有敷衍任何一份心意：陪晚晴看完落日，与清寒谈遍未来，再和星璃走过长街，最后在雨柔的歌声里迎来午夜。\n\n真正珍贵的关系，不是占有，而是坦诚、尊重与彼此成全。",
            speaker: nil, mood: "心意",
            choices: [
                StoryChoice(id: "c7p1", title: "把真心说清楚", subtitle: "不隐瞒、不辜负，所有选择都交给彼此。", symbol: "heart.fill", nextNodeID: "c7_home", effect: GameEffect(relationshipID: "lin", affection: 8, setFlags: ["honest_heart"], toast: "真诚比任何仙术更有力量")),
                StoryChoice(id: "c7p2", title: "邀请她们共赴家宴", subtitle: "重要的人，理应彼此认识。", symbol: "person.3.fill", nextNodeID: "c7_home", effect: GameEffect(relationshipID: "shen", affection: 8, setFlags: ["shared_feast"], toast: "四把钥匙，打开同一扇家门"))
            ]
        ),
        StoryNode(
            id: "c7_home", chapter: 7, chapterTitle: "人间值得", location: "李家旧宅",
            title: "灯火可亲",
            body: "院中没有仙宴，只有一桌热腾腾的家常菜。林晚晴抢救完病人才赶来，苏清寒带着仍未结束的跨国会议，沈星璃从窗户翻进院子，江雨柔则用围巾和墨镜把自己裹得严严实实。\n\n她们从最初的戒备到相视一笑。李晓鹏忽然明白，比诸天俯首更难得的，是有人等他回家。",
            speaker: "父亲", mood: "团圆",
            choices: [
                StoryChoice(id: "c7c", title: "守护这人间烟火", subtitle: "选择留在都市，与她们共度漫长岁月。", symbol: "house.and.flag.fill", nextNodeID: "ending_city", effect: GameEffect(reputation: 20, swagger: 20, setFlags: ["ending_city"])),
                StoryChoice(id: "c7d", title: "带她们游历诸天", subtitle: "世界很大，故事才刚刚开始。", symbol: "globe.asia.australia.fill", nextNodeID: "ending_heavens", effect: GameEffect(swagger: 30, setFlags: ["ending_heavens"])),
                StoryChoice(id: "c7e", title: "建立人间仙庭", subtitle: "让新时代由凡人和修士共同书写。", symbol: "building.columns.fill", nextNodeID: "ending_king", effect: GameEffect(reputation: 30, setFlags: ["ending_king"]))
            ]
        ),

        StoryNode(
            id: "ending_city", chapter: 8, chapterTitle: "终章", location: "江城",
            title: "结局·人间烟火",
            body: "李晓鹏拒绝了诸天共主之位，把旧宅扩成一座临江小院。白天，他偶尔去医院坐诊、替苏氏解决技术难题，也会被沈星璃临时抓去处理异兽；夜里，江雨柔的新歌总从院中响起。\n\n世人仍在传说那位无敌仙尊，猜测他身在何方。没人想到，他正系着围裙，为一桌争论谁先尝菜的姑娘端来最后一盘糖醋鱼。\n\n无敌于天下，也温柔于一人间。",
            speaker: nil, mood: "圆满", choices: []
        ),
        StoryNode(
            id: "ending_heavens", chapter: 8, chapterTitle: "终章", location: "诸天星海",
            title: "结局·星河同行",
            body: "九霄剑化作横跨星海的仙舟。林晚晴沿途救治异族生灵，苏清寒把生意做遍万界，沈星璃建立诸天秩序，江雨柔的歌声则成为星河共同的语言。\n\n每到一界，总有不长眼的天骄前来挑衅。李晓鹏照例隐藏修为、安静喝茶，直到对方把脸凑到跟前。\n\n新的旅程里，熟悉的巴掌声依旧响亮。",
            speaker: nil, mood: "远行", choices: []
        ),
        StoryNode(
            id: "ending_king", chapter: 8, chapterTitle: "终章", location: "人间仙庭",
            title: "结局·盛世仙庭",
            body: "人间第一座仙庭在江城成立，却没有血脉世袭，也不以境界论尊卑。林晚晴执掌医道，苏清寒掌管百业，沈星璃守护律法，江雨柔记录这个时代的声音。\n\n李晓鹏从不坐那张最高的王座。他喜欢混在新生中假装普通学员，看年轻天才们先嘲讽、再震惊、最后怀疑人生。\n\n据仙庭校史记载，院长最大的爱好，至今仍是扮猪吃虎。",
            speaker: nil, mood: "盛世", choices: []
        )
    ]
}
