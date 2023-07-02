#!/usr/bin/env python3

import pandas as pd
import sys

if __name__ == "__main__":
    lines = sys.stdin.read()
    try:
        rdata = pd.read_xml(lines, parser="etree", xpath="./queue_info/")
    except ValueError:
        rdata = pd.DataFrame([])
    try:
        qdata = pd.read_xml(lines, parser="etree", xpath="./job_info/job_list")
    except ValueError:
        qdata = pd.DataFrame([])
    data = pd.concat([rdata, qdata]).assign(
        jb_name_before_dot=lambda x: x.JB_name.str.split(".").str[0]
    )
    running_summary = (
        data[["state", "jb_name_before_dot"]]
        .value_counts()
        .unstack(fill_value=0)
        .T.join(
            data.groupby(["jb_name_before_dot", "state"])
            .JB_job_number.min()
            .unstack(fill_value=0),
            rsuffix="_id",
        )
    )
    print(running_summary)
