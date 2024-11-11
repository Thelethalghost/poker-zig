const std = @import("std");

const Suit = enum(u2) {
    Spades = 0,
    Hearts = 1,
    Diamonds = 2,
    Clubs = 3,
};

const Card = struct {
    suit: Suit,
    value: u4,

    pub fn NewCard(s: Suit, v: u4) !Card {
        if (v > 13) {
            return error.InvalidCardValue;
        }
        return Card{
            .suit = s,
            .value = v,
        };
    }
};

const Deck = [52]Card;

pub fn NewDeck() !Deck {
    var deck: Deck = undefined;
    var x: usize = 0;

    for (Suit) |suit| {
        for (1..13) |value| {
            deck[x] = try Card.NewCard(suit, value);
            x += 1;
        }
    }

    shuffle(&deck);
    return deck;
}

fn shuffle(deck: *Deck) void {
    const rng = std.rand.DefaultPrng.init(12392);

    for (deck.len - 1) |i| {
        const j = rng.int(0, i + 1);
        const temp = deck[i];
        deck[i] = deck[j];
        deck[j] = temp;
    }
}

fn suitToString(s: Suit) []const u8 {
    switch (s) {
        .Spades => "SPADES",
        .Clubs => "CLUBS",
        .Hearts => "HEARTS",
        .Diamonds => "DIAMONDS",
    }
}
