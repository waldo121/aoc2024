const std = @import("std");

// Part 1
//pub fn main() !void {
//    const file = try std.fs.cwd().openFile("input.txt", .{});
//    defer file.close();
//    var buffer: [100]u8 = undefined;
//    var safeCount: u32 = 0;
//    const Direction = enum {
//        increase,
//        decrease
//    };
//    var direction: ?Direction = null;
//    while (try file.reader().readUntilDelimiterOrEof(buffer[0..], '\n')) |line| {
//        var it = std.mem.split(u8, line, " ");
//        direction = null;
//        var previous = std.fmt.parseInt(i32, it.first(), 10) catch unreachable;
//        var unsafe: bool = false;
//
//        while (it.next()) |n| {
//            const element = std.fmt.parseInt(i32, n, 10) catch unreachable;
//            const absDiff = @abs(previous-element);
//            const diffUnsafe = absDiff < 1 or absDiff > 3; 
//            if (diffUnsafe) {
//                unsafe = true;
//                break;
//            }
//            if (previous < element) {
//                if(direction == null) {
//                    direction = Direction.increase;
//                } else if(direction.? == Direction.decrease) {
//                    unsafe = true;
//                    break;
//                } 
//            } else if(previous == element) {
//                unsafe = true;
//                break;
//            } else {
//                if(direction == null) {
//                    direction = Direction.decrease;
//                } else if(direction == Direction.increase) {
//                    unsafe = true;
//                    break;
//                }
//            }
//            previous = element;
//        }
//        if(!unsafe) {
//            safeCount += 1;
//        }
//
//    }
//    std.debug.print("Safe reports: {d}\n", .{safeCount});
//}
// Part 2
pub fn main() !void {
    const file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();
    var buffer: [100]u8 = undefined;
    var safeCount: u32 = 0;
    const Direction = enum {
        increase,
        decrease
    };
    var direction: ?Direction = null;

    while (try file.reader().readUntilDelimiterOrEof(buffer[0..], '\n')) |line| {
        var it = std.mem.split(u8, line, " ");
        direction = null;
        var previous = std.fmt.parseInt(i32, it.first(), 10) catch unreachable;
        var unsafe: bool = false;
        var levelRemoved: bool = false;
        while (it.next()) |n| {
            const element = std.fmt.parseInt(i32, n, 10) catch unreachable;
            const absDiff = @abs(previous-element);
            const diffUnsafe = absDiff < 1 or absDiff > 3 or absDiff == 0; 
            if (diffUnsafe) {
                if(levelRemoved) {
                    unsafe = true;
                    break;
                } else {
                    levelRemoved = true;
                    previous = element;
                    continue;
                }
            }
            if (previous < element) {
                if (direction == null) {
                    direction = Direction.increase;
                } else if(direction.? == Direction.decrease) {
                    if(levelRemoved) {
                        unsafe = true;
                        break;
                    } else {
                        levelRemoved = true;
                        previous = element;
                        direction = null;
                        continue;
                    }
                } 
            } else {
                if(direction == null) {
                    direction = Direction.decrease;
                } else if(direction.? == Direction.increase) {
                    if(levelRemoved) {
                        unsafe = true;
                        break;
                    } else {
                        levelRemoved = true;
                        previous = element;
                        direction = null;
                        continue;
                    }
                }
            }
            previous = element;
        }
        if(!unsafe) {
            safeCount += 1;
        }
    }
    std.debug.print("Safe reports: {d}\n", .{safeCount});
}
