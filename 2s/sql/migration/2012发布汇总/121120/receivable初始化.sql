update txn.receivable c  set member_no = ( select member_no from bcuser.member where  id = c.member_id ) where member_id is not null and member_id > 0;