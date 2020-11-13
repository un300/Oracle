



location = input()


col, row = (location[0], int(location[1]))


col_list = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
col = col_list.index(col) + 1

new_location_list = [(2, 1), (2, -1), (-2, 1), (-2, -1), (1, 2), (1, -2), (-1, 2), (-1, -2)]

cnt = 0
for new_row, new_col in new_location_list:
    change_row, change_col = row + new_row, col + new_col
    if change_col * change_row >= 1:
        cnt += 1

print(cnt)