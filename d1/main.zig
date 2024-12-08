const std = @import("std");

// Part 1
//const Context = struct {};
//fn lessThan(_: Context, a: i32, b: i32) std.math.Order {
//    return std.math.order(a, b);
//}
//pub fn main() !void {
//    const file = try std.fs.cwd().openFile("input.txt", .{});
//    defer file.close();
//    var buffer: [100]u8 = undefined;
//    const pq1_context: Context = undefined;
//    const pq2_context: Context = undefined;
//    var pq1 = std.PriorityQueue(i32, Context, lessThan).init(std.heap.page_allocator, pq1_context);
//    var pq2 = std.PriorityQueue(i32, Context, lessThan).init(std.heap.page_allocator, pq2_context);
//    defer pq1.deinit();
//    defer pq2.deinit();
//    var sum: u32 = 0;
//    while (try file.reader().readUntilDelimiterOrEof(buffer[0..], '\n')) |line| {
//        var it = std.mem.split(u8, line, "   ");
//        if (it.next()) |n1| {
//            const element = std.fmt.parseInt(i32, n1, 10) catch unreachable;
//            try pq1.add(element);
//        }
//        if (it.next()) |n2| {
//            const element = std.fmt.parseInt(i32, n2, 10) catch unreachable;
//            try pq2.add(element);
//        }
//    }
//    while (pq1.removeOrNull()) |number1| {
//        const number2 = pq2.remove();
//        sum = sum + @abs(number1 - number2);
//    }
//    std.debug.print("Absolute difference (int): {d}\n", .{sum});
//}
// Part 2
pub fn main() !void {
    const file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();
    var buffer: [100]u8 = undefined;
    var list = std.ArrayList(u32).init(std.heap.page_allocator);
    var map = std.AutoHashMap(u32, u32).init(std.heap.page_allocator);
    defer list.deinit();
    defer map.deinit();
    var sum: u32 = 0;

    while (try file.reader().readUntilDelimiterOrEof(buffer[0..], '\n')) |line| {
        var it = std.mem.split(u8, line, "   ");
        if (it.next()) |n1| {
            const element = std.fmt.parseInt(u32, n1, 10) catch unreachable;
            try list.append(element);
        }
        if (it.next()) |n2| {
            const element = std.fmt.parseInt(u32, n2, 10) catch unreachable;
            if (map.contains(element)) {
                const previous: u32 = map.get(element).?;
                try map.put(element, previous + 1);
            } else {
                try map.put(element, 1);
            }
        }
    }
    for (list.items) |element| {
        const number: ?u32 = map.get(element);
        if (number != null) {
            sum = sum + number.? * element;
        }
    }
    std.debug.print("Absolute difference (int): {d}\n", .{sum});
}
